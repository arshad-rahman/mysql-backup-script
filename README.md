# 🗄️ MySQL Backup Script

Automate your MySQL database backups with a simple Bash script—gzip‑compressed dumps, timestamped filenames, and automatic cleanup of old backups.

<p align="center">
  <a href="https://github.com/arshad-rahman/mysql-backup-script">
    <img src="https://img.shields.io/badge/Backup-MySQL-blue?style=for-the-badge" alt="MySQL Backup">
  </a>
</p>

---

## 📋 Table of Contents

- [Features](#features)  
- [Prerequisites](#prerequisites)  
- [Configuration](#configuration)  
- [Installation](#installation)  
- [Usage](#usage)  
- [Scheduling (Cron)](#scheduling-cron)  
- [Contributing](#contributing)  
- [License](#license)

---

## Features

- ✅ Full database dump via `mysqldump`  
- 🔄 Gzip compression for minimal storage  
- 🗓️ Timestamped backup filenames  
- 🧹 Automatic removal of backups older than _N_ days  

---

## Prerequisites

- **Bash** shell (Linux/macOS/WSL on Windows)  
- **MySQL client tools** installed (`mysqldump`)  
- Write & execute permissions on the backup directory  
- `gzip` utility installed  

Install on Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y mysql-client gzip
````

On CentOS/RHEL:

```bash
sudo yum install -y mysql gzip
```

---

## Configuration

Edit the top section of `mysql-backup.sh` to match your environment:

```bash
# === CONFIGURATION ===
DB_USER="root"                # MySQL user name
DB_PASS="yourpassword"        # MySQL user password
DB_NAME="yourdatabase"        # Name of the database to back up
BACKUP_DIR="/var/backups/mysql" # Path where backups will be stored
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql.gz"
RETENTION_DAYS=7              # Days to keep old backups
```

Prepare the backup directory:

```bash
sudo mkdir -p /var/backups/mysql
sudo chown $USER:$USER /var/backups/mysql
chmod 700 /var/backups/mysql
```

---

## Installation

```bash
# 1. Clone the repo
git clone https://github.com/arshad-rahman/mysql-backup-script.git
cd mysql-backup-script

# 2. Make the script executable
chmod +x mysql-backup.sh
```

---

## Usage

Run the backup script:

```bash
./mysql-backup.sh
```

You’ll see output like:

```
[+] Backing up MySQL database: yourdatabase
[✓] Backup successful: /var/backups/mysql/yourdatabase_2025-07-01_12-30-00.sql.gz
[*] Removing backups older than 7 days...
[✓] Cleanup complete.
```

---

## Scheduling (Cron)

To automate daily at 2 AM, add to your crontab (`crontab -e`):

```cron
0 2 * * * /home/youruser/mysql-backup-script/mysql-backup.sh >> /var/log/mysql-backup.log 2>&1
```

Ensure the log directory exists and is writable:

```bash
sudo mkdir -p /var/log
sudo touch /var/log/mysql-backup.log
sudo chown $USER:$USER /var/log/mysql-backup.log
```

---

## Contributing

Contributions, issues, and feature requests are welcome! To contribute:

1. Fork this repo
2. Create a branch:

   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit your changes:

   ```bash
   git commit -m "Add feature or fix"
   ```
4. Push & open a PR:

   ```bash
   git push origin feature/your-feature
   ```

---

## License

This project is licensed under the [MIT License](LICENSE).

<p align="center">
  Built with ❤️ by <a href="https://github.com/arshad-rahman">Arshad Rahman</a>
</p>
