#!/usr/bin/env bash
# ============================================================
#  Dotfiles Uninstall Script
#  Removes symlinks created by install.sh
#  Restores backups from ~/.cache/dotfiles-backup-<timestamp>
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

# ── Helpers ──────────────────────────────────────────────────
info()    { echo -e "${CYAN}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }

# ── Banner ───────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${RED}╔══════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${RED}║       HyprDev Dotfiles Uninstaller       ║${RESET}"
echo -e "${BOLD}${RED}╚══════════════════════════════════════════╝${RESET}"
echo ""

# ── Select backup ────────────────────────────────────────────
CACHE_DIR="$HOME/.cache"
BACKUPS=()
while IFS= read -r -d '' entry; do
    BACKUPS+=("$entry")
done < <(find "$CACHE_DIR" -maxdepth 1 -name "dotfiles-backup-*" -type d -print0 | sort -rz)

if [ "${#BACKUPS[@]}" -eq 0 ]; then
    error "No dotfiles backup found in $CACHE_DIR"
    error "Nothing to restore — aborting."
    exit 1
fi

if [ "${#BACKUPS[@]}" -eq 1 ]; then
    BACKUP_DIR="${BACKUPS[0]}"
    info "Using backup: $BACKUP_DIR"
else
    echo -e "${BOLD}Multiple backups found:${RESET}"
    for i in "${!BACKUPS[@]}"; do
        echo -e "  ${CYAN}[$((i+1))]${RESET} ${BACKUPS[$i]}"
    done
    echo ""
    read -rp "$(echo -e "${BOLD}Choose backup to restore [1-${#BACKUPS[@]}] (default: 1): ${RESET}")" choice
    choice="${choice:-1}"
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#BACKUPS[@]}" ]; then
        error "Invalid selection — aborting."
        exit 1
    fi
    BACKUP_DIR="${BACKUPS[$((choice-1))]}"
fi

MANIFEST="$BACKUP_DIR/manifest.txt"

if [ ! -f "$MANIFEST" ]; then
    error "Manifest not found at $MANIFEST"
    error "Cannot safely uninstall without a manifest — aborting."
    exit 1
fi

echo ""
info "Backup  : $BACKUP_DIR"
info "Manifest: $MANIFEST"
echo ""

# ── Confirm ──────────────────────────────────────────────────
echo -e "${YELLOW}This will remove all installed dotfile symlinks and restore your previous configs.${RESET}"
read -rp "$(echo -e "${BOLD}Continue? [y/N]: ${RESET}")" confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    info "Aborted."
    exit 0
fi
echo ""

# ── Process manifest ─────────────────────────────────────────
echo -e "${BOLD}Removing symlinks and restoring backups…${RESET}"

while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue

    IFS=':' read -r type dest extra <<< "$line"

    case "$type" in
        link)
            # dest = installed symlink path, extra = original source
            if [ -L "$dest" ]; then
                rm "$dest"
                success "Removed symlink: $dest"
            elif [ -e "$dest" ]; then
                warn "$dest exists but is not a symlink — leaving untouched"
            else
                warn "$dest not found — already removed?"
            fi
            ;;
        backup)
            # dest = original path, extra = backup path
            backup_path="$extra"
            if [ -e "$backup_path" ]; then
                # Only restore if the location is now free (we just removed the symlink above)
                if [ ! -e "$dest" ] && [ ! -L "$dest" ]; then
                    cp -r "$backup_path" "$dest"
                    success "Restored: $dest"
                else
                    warn "$dest still exists — skipping restore (backup kept at $backup_path)"
                fi
            else
                warn "Backup not found at $backup_path — cannot restore $dest"
            fi
            ;;
        *)
            warn "Unknown manifest entry type '$type' — skipping: $line"
            ;;
    esac
done < "$MANIFEST"

echo ""

# ── Ask to delete backup ─────────────────────────────────────
read -rp "$(echo -e "${BOLD}Delete the backup directory? [y/N]: ${RESET}")" del_backup
if [[ "$del_backup" =~ ^[Yy]$ ]]; then
    rm -rf "$BACKUP_DIR"
    success "Backup deleted: $BACKUP_DIR"
else
    info "Backup kept at: $BACKUP_DIR"
fi

echo ""
echo -e "${BOLD}${GREEN}Uninstall complete!${RESET}"
echo ""
