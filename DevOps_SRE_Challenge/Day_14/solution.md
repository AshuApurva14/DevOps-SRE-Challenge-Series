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

Let's solve these practical problems.

Task 1: Users and group

- I Created users riya, amit, neha

   - `for u in riya amit neha; do sudo useradd -m -s /bin/bash "$u" || true; done`

- I Created devops group and added the users

   - `sudo groupadd devops || true`

   - `for u in riya amit neha; do sudo usermod -aG devops "$u"; done`

- Saved id outputs to ~/perm-lab/users.txt

<img width="2446" height="1000" alt="Image" src="https://github.com/user-attachments/assets/797072a4-9166-4f25-8900-be717482a660" />

---

Task 2: Team directory

- I Created /projects/infra as root:devops with 2770

   ```bash
   sudo mkdir -p /projects/infra
   sudo chown root:devops /projects/infra
   sudo chmod 2770 /projects/infra  

   ```

- Below I have used above users to show that files created by any member are editable by others.

   ```bash

     sudo su riya

     echo "Hi I am riya, let's collaborate" > /projects/infra/file1.txt

     sudo su amit

     echo "Hey Riya, I am amit, Thanks for your invitaion" >> /rpjects/infra/file1.txt

   ```
  

- Outputs for ls -l and a short note are to saved ~/perm-lab/teamspace.md

<img width="2742" height="1598" alt="Image" src="https://github.com/user-attachments/assets/06f80331-6dbf-4484-a193-cb68e397e594" />

<img width="2762" height="614" alt="Image" src="https://github.com/user-attachments/assets/2d9bdb35-85e3-4b4f-b719-06b9a5efc5e8" />

---

Task 3: Fix permissions

For this task below are the steps which needs to followed:

- Created dir /opt/app with ownership as root:root with mode 600.

  - `sudo mkdir -p /opt/app`
  - `sudo chown root:root /opt/app`
  - `sudo chmod 600 /opt/app`


- I Created appsvc user (no password needed).

  - `sudo useradd appsvc`


  <img width="1750" height="1470" alt="Image" src="https://github.com/user-attachments/assets/a0354fd5-60e4-4376-89be-132a0eaa6272" />


- Now, to fix this issue I have granted the file and directory permissions (dirs 750, files 640.) with owner and group permission (appsvc:appsvc).
 
  - `sudo find /opt/app -type d -exec chmod 750 {}\;`
  - `sudo find /opt/app -type f -exec chmod 640 {}\;`


- Prove appsvc can read configs; others cannot

- Outputs of all above commands and stat are saved to  ~/perm-lab/appfix.md

<img width="2158" height="1280" alt="Image" src="https://github.com/user-attachments/assets/e42ef35d-184c-4404-8f6b-94de949fb9c6" />

---

Task 4: One troubleshooting case

I have created a troubleshooting scenario by removing execution permission from `~/perm-lab/infra` directory.Below steps show how to to troublsehoot this issue.

- Intentionally, I have removed the execution permission (e.g., remove x from a parent directory)

  - `sudo chmod -x ~/perm-lab/infra`

- Then, I Used namei -l to find the missing execute bit and fix it

- Also, I have saved before/after to ~/perm-lab/troubleshoot.md

<img width="2752" height="1278" alt="Image" src="https://github.com/user-attachments/assets/f94741db-b9ac-4954-aa63-e1b08889ad42" />


<img width="2628" height="822" alt="Image" src="https://github.com/user-attachments/assets/5881c33c-d576-4734-b89a-9779067a5729" />

---

## Key Takeaways

