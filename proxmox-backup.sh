#!/bin/bash
# backup-proxmox-config.sh
#

# Set Backup DIRECTORY
BACKUP_DIR="/mnt/path/to/proxmox-backups/folder"
DATE=$(date +%F_%H-%M)
TMPDIR=$(mktemp -d)

# What you need to backup (Can add or remove)
BACKUP_ITEMS=(
    "/etc/pve"
    "/etc/network/interfaces"
    "/etc/fstab"
    "/etc/iptables"
    "/etc/nginx"
    "/root/.bashrc"
     # Additional  "/root/scripts"
)

mkdir -p "$BACKUP_DIR"

for ITEM in "${BACKUP_ITEMS[@]}"; do
    if [ -e "$ITEM" ]; then
        SAFE_NAME=$(echo "$ITEM" | sed 's|/|_|g' | sed 's/^_//')
        DEST="$TMPDIR/$SAFE_NAME"
        mkdir -p "$(dirname "$DEST")"
        cp -a "$ITEM" "$DEST"
    else
        echo "Skipped: $ITEM (not found)"
    fi
done

ARCHIVE="$BACKUP_DIR/proxmox-config-$DATE.tar.gz"
tar -czf "$ARCHIVE" -C "$TMPDIR" .

echo "DONE: $ARCHIVE"

rm -rf "$TMPDIR"
