# Daily DevOps + SRE Challenge Series – Season 2
## Day 14: Linux Users, Groups, and Permissions – Essentials for DevOps/SRE

## Solution for Day 14 Challenge
---

###  Practical Scenarios

Scenario A: Create users and a devops group
```bash
# Users
for u in riya amit neha; do sudo useradd -m -s /bin/bash "$u" || true; done
# Group
sudo groupadd devops || true
# Add users to group
for u in riya amit neha; do sudo usermod -aG devops "$u"; done
# Verify
for u in riya amit neha; do id "$u"; done
```

Scenario B: Team workspace that “just works”
Goal: Everyone in devops can create/edit files in /projects/infra; others blocked.
```bash
sudo mkdir -p /projects/infra
sudo chown root:devops /projects/infra
sudo chmod 2770 /projects/infra     # setgid ensures new files use group devops
# Test (from different users): create files and edit each other’s files
```

Scenario C: Fix a broken web app folder
Symptom: Nginx can’t read /var/www/html (403/404).
```bash
# Debian/Ubuntu typical web user
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod 755 {} \;
sudo find /var/www/html -type f -exec chmod 644 {} \;
```

Scenario D: Quick account hygiene
```bash
# Lock an unused account
sudo usermod -L guest
# Set password policy for riya
sudo chage -M 90 -m 7 -W 14 riya
# See current policy
chage -l riya
```

Scenario E: Troubleshoot “Permission denied”
Checklist:
- ls -ld path; stat file
- namei -l /deep/nested/path (shows each directory’s x bit)
- id user (group membership)
- If it’s a team dir, ensure setgid and group membership are correct
Commands:
```bash
namei -l /srv/app/config/app.env
id appsvc
ls -ld /srv /srv/app /srv/app/config
```
