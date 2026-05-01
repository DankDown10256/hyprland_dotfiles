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

backup_and_copy() {
    local src="$1"   # absolute path to source dir (in repo)
    local dest="$2"  # absolute path to destination dir (in $HOME)
    local label="$3" # display name

    # If dest is a symlink (old install), remove it so we can replace with a real dir
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
        warn "$label backed up to $backup_path"
    fi

    mkdir -p "$dest"
    cp -r "$src/." "$dest/"
    echo "copy:$dest:$src" >> "$MANIFEST"
    success "$label → $dest"
}

# ── Banner ───────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${BLUE}║       HyprDev Installer                  ║${RESET}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════╝${RESET}"
echo ""
info "Source  : $SCRIPT_DIR"
info "Config  : ~/.config/"
info "Backup  : $BACKUP_DIR"
echo ""

# ── Create backup dir ────────────────────────────────────────
mkdir -p "$BACKUP_DIR"
echo "# Dotfiles install manifest — $TIMESTAMP" > "$MANIFEST"
echo "# Format: type:destination:source_or_backup_path" >> "$MANIFEST"
echo "" >> "$MANIFEST"

# ── Install ~/.config/* ──────────────────────────────────────
echo -e "${BOLD}Installing configs…${RESET}"
mkdir -p "$HOME/.config"

for src_dir in "$CONFIGS_SRC"/*/; do
    [ -d "$src_dir" ] || continue
    app="$(basename "$src_dir")"
    dest="$HOME/.config/$app"
    backup_and_copy "$src_dir" "$dest" "$app"
done

echo ""

# ── Install home assets ──────────────────────────────────────
echo -e "${BOLD}Installing home assets…${RESET}"

declare -A HOME_DIRS=(
    ["walls"]="$HOME/walls"
    ["pfps"]="$HOME/pfps"
)

for name in "${!HOME_DIRS[@]}"; do
    src="$HOME_SRC/$name"
    dest="${HOME_DIRS[$name]}"
    if [ -d "$src" ]; then
        backup_and_copy "$src" "$dest" "$name"
    else
        warn "home/$name not found — skipping"
    fi
done

echo ""

# ── Done ─────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}Installation complete!${RESET}"
echo ""
echo -e "  Backup location : ${CYAN}$BACKUP_DIR${RESET}"
echo -e "  Manifest        : ${CYAN}$MANIFEST${RESET}"
echo ""
echo -e "  To uninstall and restore your previous configs, run:"
echo -e "  ${BOLD}./uninstall.sh${RESET}"
echo ""
