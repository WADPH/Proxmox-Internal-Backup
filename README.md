# Proxmox-Internal-Backup
## Backup internal proxmox host folders

1. Clone the repo
```bash
git clone https://github.com/WADPH/Proxmox-Internal-Backup.git
cd Proxmox-Internal-Backup
chmod +x proxmox-backup.sh
````

2. [OPTIONAL] Change config:
```bash
nano proxmox-backup.sh
````

4. Create cron task:
```bash
crontab -e
0 3 * * 7 /root/scripts/backup-proxmox.sh
````
