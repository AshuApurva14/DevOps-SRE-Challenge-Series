# Daily DevOps + SRE Challenge Series – Season 2
## Day 14: Linux Users, Groups, and Permissions – Essentials for DevOps/SRE

## Solution for Day 14 Challenge

This challenge is all about solving scenarios based on user, group creations and permissions.It tests your knowledge on user management skills in linux.

---

### Why to use setgid and its significance?

 - Setting the setgid bit simplifies group management and ensures proper access control in shared environments and for specific executable programs requiring elevated group privileges.

 **Example:**

`sudo chmod 2770 /projects/infra  `

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

The below commands modify the `/var/www/html` files and folders ownership.

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
---

## Practical Tasks: Build, Share, Fix

Do these and capture the commands and outputs.

Task 1: Users and group
- Create users riya, amit, neha
- Create devops group and add the users
- Save id outputs to ~/perm-lab/users.txt

Task 2: Team directory
- Create /projects/infra as root:devops with 2770
- Show that files created by any member are editable by others
- Save ls -l and a short note to ~/perm-lab/teamspace.md

Task 3: Fix permissions
- Simulate a broken app dir /opt/app owned by root:root with mode 600
- Create appsvc user (no password needed)
- Fix to appsvc:appsvc, dirs 750, files 640
- Prove appsvc can read configs; others cannot
- Save commands and stat outputs to ~/perm-lab/appfix.md

Task 4: One troubleshooting case
- Break something intentionally (e.g., remove x from a parent directory)
- Use namei -l to find the missing execute bit and fix it
- Save before/after to ~/perm-lab/troubleshoot.md

