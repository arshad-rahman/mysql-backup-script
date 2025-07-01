#!/bin/bash

# === CONFIGURATION ===
DB_USER="root"
DB_PASS="yourpassword"
DB_NAME="yourdatabase"
BACKUP_DIR="/var/backups/mysql"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql.gz"
RETENTION_DAYS=7

# === CREATE BACKUP DIRECTORY ===
mkdir -p "$BACKUP_DIR"

# === PERFORM BACKUP ===
echo "[+] Backing up MySQL database: $DB_NAME"
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" | gzip > "$BACKUP_FILE"

# === VERIFY BACKUP ===
if [ -f "$BACKUP_FILE" ]; then
    echo "[✓] Backup successful: $BACKUP_FILE"
else
    echo "[✗] Backup failed!"
    exit 1
fi

# === DELETE OLD BACKUPS ===
echo "[*] Removing backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

echo "[✓] Cleanup complete."
