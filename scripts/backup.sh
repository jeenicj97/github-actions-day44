#!/bin/bash
set -euo pipefail

SOURCE_DIR="./data"          
BACKUP_DIR="./backups"       
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory '$SOURCE_DIR' does not exist."
  exit 1
fi

mkdir -p "$BACKUP_DIR"

echo "Starting backup of '$SOURCE_DIR'..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_DIR/$BACKUP_FILE"
else
  echo "Backup failed!"
  exit 1
fi

echo "Cleaning up old backups (keeping last 5)..."
cd "$BACKUP_DIR"
ls -t backup_*.tar.gz | tail -n +6 | xargs -r rm --

echo "Done."
