#!/usr/bin/env bash
# ============================================================
#  Dotfiles Install Script
#  configs/* → ~/.config/*
#  home/walls → ~/walls  |  home/pfps → ~/pfps
#  Backups existing files to ~/.cache/dotfiles-backup-<timestamp>
# ============================================================

set -euo pipefail

# ── Colors ──────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Paths ────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_SRC="$SCRIPT_DIR/configs"
HOME_SRC="$SCRIPT_DIR/home"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="$HOME/.cache/dotfiles-backup-$TIMESTAMP"
MANIFEST="$BACKUP_DIR/manifest.txt"

# ── Helpers ──────────────────────────────────────────────────
info()    { echo -e "${CYAN}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }

# ── Detect user ──────────────────────────────────────────────
CURRENT_USER="${SUDO_USER:-${USER:-$(whoami)}}"
CURRENT_HOME=$(eval echo "~$CURRENT_USER")

# ── Detect distro ────────────────────────────────────────────
detect_distro() {
    if [ -f /etc/os-release ]; then
        # shellcheck source=/dev/null
        source /etc/os-release
        DISTRO_ID="${ID:-unknown}"
        DISTRO_ID_LIKE="${ID_LIKE:-}"
        DISTRO_NAME="${PRETTY_NAME:-$NAME}"
    elif command -v lsb_release &>/dev/null; then
        DISTRO_ID=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
        DISTRO_NAME=$(lsb_release -sd)
        DISTRO_ID_LIKE=""
    else
        DISTRO_ID="unknown"
        DISTRO_NAME="Unknown"
        DISTRO_ID_LIKE=""
    fi

    # Normalize to a family
    case "$DISTRO_ID" in
        arch|cachyos|endeavouros|manjaro|garuda)
            DISTRO_FAMILY="arch" ;;
        gentoo|funtoo)
            DISTRO_FAMILY="gentoo" ;;
        ubuntu|debian|linuxmint|pop|zorin|elementary|kali)
            DISTRO_FAMILY="debian" ;;
        fedora|rhel|centos|almalinux|rocky)
            DISTRO_FAMILY="fedora" ;;
        opensuse*|suse*)
            DISTRO_FAMILY="opensuse" ;;
        *)
            # Fallback via ID_LIKE
            if echo "$DISTRO_ID_LIKE" | grep -q "arch"; then
                DISTRO_FAMILY="arch"
            elif echo "$DISTRO_ID_LIKE" | grep -q "debian\|ubuntu"; then
                DISTRO_FAMILY="debian"
            elif echo "$DISTRO_ID_LIKE" | grep -q "fedora\|rhel"; then
                DISTRO_FAMILY="fedora"
            elif echo "$DISTRO_ID_LIKE" | grep -q "suse"; then
                DISTRO_FAMILY="opensuse"
            else
                DISTRO_FAMILY="unknown"
            fi
            ;;
    esac
}

detect_distro

# ── Banner ───────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${BLUE}║       HyprDev Installer                  ║${RESET}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════╝${RESET}"
echo ""
info "Utilisateur : ${BOLD}$CURRENT_USER${RESET}"
info "Distro      : ${BOLD}$DISTRO_NAME${RESET} (famille : $DISTRO_FAMILY)"
info "Source      : $SCRIPT_DIR"
info "Config      : $CURRENT_HOME/.config/"
info "Backup      : $BACKUP_DIR"
echo ""

# ── Packages ─────────────────────────────────────────────────
# Format: "pkg_arch|pkg_gentoo|pkg_debian|pkg_fedora|pkg_opensuse"
# Un underscore _ = paquet non disponible dans les dépôts officiels
PACKAGES=(
    # Hyprland core
    "hyprland|gui-wm/hyprland|_|hyprland|hyprland"
    "hyprlock|gui-apps/hyprlock|_|hyprlock|hyprlock"
    "hypridle|gui-apps/hypridle|_|hypridle|hypridle"
    # Composants Wayland
    "waybar|gui-apps/waybar|waybar|waybar|waybar"
    "swaync|gui-apps/swaync|_|swaync|_"
    "wlogout|gui-apps/wlogout|_|wlogout|_"
    "fuzzel|gui-apps/fuzzel|fuzzel|fuzzel|fuzzel"
    "rofi-wayland|x11-misc/rofi|rofi|rofi-wayland|rofi"
    # Terminaux
    "kitty|x11-terms/kitty|kitty|kitty|kitty"
    "ghostty|app-terminals/ghostty|_|_|_"
    # Wallpaper
    "swww|gui-apps/swww|_|swww|_"
    # Gestionnaires de fichiers
    "nautilus|gnome-base/nautilus|nautilus|nautilus|nautilus"
    "yazi|app-misc/yazi|_|yazi|_"
    # Audio / Vidéo
    "pipewire|media-video/pipewire|pipewire|pipewire|pipewire"
    "wireplumber|media-video/wireplumber|wireplumber|wireplumber|pipewire-wireplumber"
    "pulseaudio-utils|media-sound/pulseaudio|pulseaudio-utils|pulseaudio-utils|pulseaudio-utils"
    # Luminosité & périphériques
    "brightnessctl|sys-power/brightnessctl|brightnessctl|brightnessctl|brightnessctl"
    "udiskie|app-misc/udiskie|udiskie|udiskie|udiskie"
    # Outils système
    "btop|sys-process/btop|btop|btop|btop"
    "fastfetch|app-misc/fastfetch|fastfetch|fastfetch|fastfetch"
    # Médias / Musique
    "cava|media-sound/cava|cava|cava|_"
    "ncspot|media-sound/ncspot|_|_|_"
    # Éditeur de texte
    "featherpad|app-editors/featherpad|featherpad|featherpad|featherpad"
    # Thème
    "matugen|app-misc/matugen|_|_|_"
)

# ── Install packages ─────────────────────────────────────────
install_pkg_arch() {
    local pkg="$1"
    [ "$pkg" = "_" ] && return 1
    if command -v paru &>/dev/null; then
        paru -S --needed --noconfirm "$pkg"
    elif command -v yay &>/dev/null; then
        yay -S --needed --noconfirm "$pkg"
    else
        pacman -S --needed --noconfirm "$pkg"
    fi
}

install_pkg_gentoo() {
    local pkg="$1"
    [ "$pkg" = "_" ] && return 1
    emerge --ask=n --quiet "$pkg"
}

install_pkg_debian() {
    local pkg="$1"
    [ "$pkg" = "_" ] && return 1
    apt-get install -y "$pkg"
}

install_pkg_fedora() {
    local pkg="$1"
    [ "$pkg" = "_" ] && return 1
    dnf install -y "$pkg"
}

install_pkg_opensuse() {
    local pkg="$1"
    [ "$pkg" = "_" ] && return 1
    zypper install -y "$pkg"
}

install_dependencies() {
    echo -e "${BOLD}Installation des dépendances pour ${DISTRO_NAME}…${RESET}"
    echo ""

    local skipped=()
    local installed=()
    local failed=()

    for entry in "${PACKAGES[@]}"; do
        IFS='|' read -r pkg_arch pkg_gentoo pkg_debian pkg_fedora pkg_opensuse <<< "$entry"

        case "$DISTRO_FAMILY" in
            arch)    pkg="$pkg_arch" ;;
            gentoo)  pkg="$pkg_gentoo" ;;
            debian)  pkg="$pkg_debian" ;;
            fedora)  pkg="$pkg_fedora" ;;
            opensuse) pkg="$pkg_opensuse" ;;
            *)       pkg="_" ;;
        esac

        # Nom d'affichage basé sur le premier champ (arch)
        display_name="$pkg_arch"

        if [ "$pkg" = "_" ]; then
            warn "$display_name — non disponible dans les dépôts officiels pour $DISTRO_FAMILY, installation manuelle requise"
            skipped+=("$display_name")
            continue
        fi

        if install_pkg_"$DISTRO_FAMILY" "$pkg" 2>/dev/null; then
            success "$display_name installé"
            installed+=("$display_name")
        else
            warn "$display_name — échec de l'installation ($pkg)"
            failed+=("$display_name")
        fi
    done

    echo ""
    echo -e "${BOLD}Résumé des dépendances :${RESET}"
    echo -e "  ${GREEN}Installés  : ${#installed[@]}${RESET}"
    echo -e "  ${YELLOW}Ignorés    : ${#skipped[@]}${RESET}"
    [ ${#skipped[@]} -gt 0 ] && echo -e "    → ${skipped[*]}"
    echo -e "  ${RED}Échoués    : ${#failed[@]}${RESET}"
    [ ${#failed[@]} -gt 0 ] && echo -e "    → ${failed[*]}"
    echo ""
}

# ── Backup & copy ────────────────────────────────────────────
backup_and_copy() {
    local src="$1"
    local dest="$2"
    local label="$3"

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        local bname
        bname="$(basename "$dest")"
        local backup_path="$BACKUP_DIR/$bname"
        local counter=1
        while [ -e "$backup_path" ]; do
            backup_path="${BACKUP_DIR}/${bname}_${counter}"
            ((counter++))
        done
        cp -r "$dest" "$backup_path"
        echo "backup:$dest:$backup_path" >> "$MANIFEST"
        warn "$label sauvegardé dans $backup_path"
    fi

    mkdir -p "$dest"
    cp -r "$src/." "$dest/"
    echo "copy:$dest:$src" >> "$MANIFEST"
    success "$label → $dest"
}

# ── Demander l'installation des dépendances ──────────────────
echo -e "${BOLD}Voulez-vous installer les dépendances ? [o/N]${RESET} "
read -r -n1 REPLY
echo ""
if [[ "$REPLY" =~ ^[oOyY]$ ]]; then
    if [ "$DISTRO_FAMILY" = "unknown" ]; then
        error "Distro non reconnue ($DISTRO_ID), installation automatique impossible."
        warn "Installez manuellement : hyprland hyprlock hypridle waybar swaync wlogout kitty rofi swww pipewire wireplumber brightnessctl udiskie btop fastfetch cava"
    else
        # Vérifier les droits sudo si nécessaire
        if [ "$DISTRO_FAMILY" != "arch" ] && [ "$(id -u)" != "0" ]; then
            if command -v sudo &>/dev/null; then
                export SUDO_INSTALL=1
                # Relancer avec sudo uniquement la partie install
                warn "Droits root requis — relance avec sudo…"
                sudo bash -c "
                    source /etc/os-release 2>/dev/null || true
                    DISTRO_FAMILY='$DISTRO_FAMILY'
                    $(declare -f install_pkg_arch install_pkg_gentoo install_pkg_debian install_pkg_fedora install_pkg_opensuse)
                    case '$DISTRO_FAMILY' in
                        gentoo)  emerge --ask=n --quiet $(printf '%s ' $(printf '%s\n' "${PACKAGES[@]}" | cut -d'|' -f2 | grep -v '^_$')) ;;
                        debian)  apt-get install -y $(printf '%s ' $(printf '%s\n' "${PACKAGES[@]}" | cut -d'|' -f3 | grep -v '^_$')) ;;
                        fedora)  dnf install -y $(printf '%s ' $(printf '%s\n' "${PACKAGES[@]}" | cut -d'|' -f4 | grep -v '^_$')) ;;
                        opensuse) zypper install -y $(printf '%s ' $(printf '%s\n' "${PACKAGES[@]}" | cut -d'|' -f5 | grep -v '^_$')) ;;
                    esac
                "
            else
                error "sudo non disponible — lancez le script en root pour installer les paquets."
            fi
        else
            install_dependencies
        fi
    fi
else
    info "Installation des dépendances ignorée."
fi

echo ""

# ── Créer le dossier de backup ───────────────────────────────
mkdir -p "$BACKUP_DIR"
echo "# Dotfiles install manifest — $TIMESTAMP" > "$MANIFEST"
echo "# Format: type:destination:source_or_backup_path" >> "$MANIFEST"
echo "" >> "$MANIFEST"

# ── Installer ~/.config/* ────────────────────────────────────
echo -e "${BOLD}Installation des configs…${RESET}"
mkdir -p "$CURRENT_HOME/.config"

for src_dir in "$CONFIGS_SRC"/*/; do
    [ -d "$src_dir" ] || continue
    app="$(basename "$src_dir")"
    dest="$CURRENT_HOME/.config/$app"
    backup_and_copy "$src_dir" "$dest" "$app"
done

echo ""

# ── Installer les assets home ────────────────────────────────
echo -e "${BOLD}Installation des assets home…${RESET}"

declare -A HOME_DIRS=(
    ["walls"]="$CURRENT_HOME/walls"
    ["pfps"]="$CURRENT_HOME/pfps"
)

for name in "${!HOME_DIRS[@]}"; do
    src="$HOME_SRC/$name"
    dest="${HOME_DIRS[$name]}"
    if [ -d "$src" ]; then
        backup_and_copy "$src" "$dest" "$name"
    else
        warn "home/$name introuvable — ignoré"
    fi
done

echo ""

# ── Correction des permissions ────────────────────────────────
if [ "$CURRENT_USER" != "$(whoami)" ]; then
    chown -R "$CURRENT_USER":"$CURRENT_USER" "$CURRENT_HOME/.config/hypr" \
        "$CURRENT_HOME/.config/waybar" \
        "$CURRENT_HOME/.config/kitty" 2>/dev/null || true
fi

# ── Done ─────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}Installation terminée !${RESET}"
echo ""
echo -e "  Utilisateur     : ${CYAN}$CURRENT_USER${RESET}"
echo -e "  Distro          : ${CYAN}$DISTRO_NAME${RESET}"
echo -e "  Backup          : ${CYAN}$BACKUP_DIR${RESET}"
echo -e "  Manifest        : ${CYAN}$MANIFEST${RESET}"
echo ""
echo -e "  Pour désinstaller et restaurer vos configs :"
echo -e "  ${BOLD}./uninstall.sh${RESET}"
echo ""
