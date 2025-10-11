# Daily DevOps + SRE Challenge Series – Season 2

# Solution
## Day 13: Secure Shell Mastery – SSH, SCP, Hardening & Troubleshooting Like a Pro

## Practical Tasks: Operation Secure Access – Harden, Validate, and Recover
For this lab I have used Ubuntu based machine. All the task has been completed on same machine.


### Setup Prep
1. I have created a workspace:
```bash
mkdir -p ~/ssh-lab && cd ~/ssh-lab
```
<img width="2768" height="472" alt="Image" src="https://github.com/user-attachments/assets/02ecbb78-2f19-4bab-854d-67e4e13d9670" />

---
 
### Task A: Key-Based Login 
1. I have Generated key with below commands to be used for ssh connectivity:
```bash
ssh-keygen -t ed25519 -C "devopssre@gmail.com"
```

<img width="2690" height="724" alt="Image" src="https://github.com/user-attachments/assets/6809bd5b-c291-4fad-82e9-b1eda2e33dcc" />

2. Thereafter, I have added the public key:
```bash

cat ~/.ssh/id_ed25519.pub | ssh -i aws-key.pem ubuntu@15.206.80.5 'chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
```
<img width="2764" height="168" alt="Image" src="https://github.com/user-attachments/assets/4bd791a3-e8ff-4abe-90bf-6a7922cd34bc" />

3. I verified the connection:
```bash
ssh -vvv ubuntu@15.206.80.5 "echo OK && id -u && hostname"
```

<img width="2762" height="1574" alt="Image" src="https://github.com/user-attachments/assets/38047cc9-4a4b-438a-9739-0ae37a553695" />

---

4.  Authentication verfication done “Authentication succeeded (publickey)”

<img width="2324" height="124" alt="Image" src="https://github.com/user-attachments/assets/1ea7f6e4-4504-4952-90a7-1cb68b8847ef" />

---

### Task B: Harden sshd

For this task, I have opened FW needs to be for AWS EC2 instance.

1. Opened firewall for new port (2222 shown below).


2. EditED `/etc/ssh/sshd_config` to include:
```
Port 2222
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
AllowUsers user
MaxAuthTries 3
PermitEmptyPasswords no
ClientAliveInterval 300
ClientAliveCountMax 2
LogLevel VERBOSE
```
<img width="2884" height="1704" alt="Image" src="https://github.com/user-attachments/assets/91cd802c-239d-43dd-a14e-39f61bc34203" />

3. then Validated and reloaded:
```bash
sudo sshd -t && sudo systemctl reload sshd
```
<img width="2888" height="1136" alt="Image" src="https://github.com/user-attachments/assets/8a13398e-27e3-45d8-a3ad-762dc2668119" />

4. Now, I Tested new port:
```bash
ssh -p 2222 user@server "echo PORT_OK"
```
<img width="2882" height="1146" alt="Image" src="https://github.com/user-attachments/assets/c939c80a-d4a7-4295-9234-5fb9fc2f4264" />

5. I have Removed old port (only after verifying new):
- UFW: `sudo ufw delete allow 22/tcp`
- firewalld: `sudo firewall-cmd --remove-service=ssh --permanent && sudo firewall-cmd --reload`

<img width="2890" height="146" alt="Image" src="https://github.com/user-attachments/assets/6e4823a5-5bad-49fb-b08d-9cf4269e05d2" />

---

### Task C: Secure File Transfer Roundtrip
1. I Created a file and uploaded/downloaded:
```bash
echo "hello-ssh" > hello.txt
scp -P 2222 hello.txt user@server:/tmp/hello.txt
scp -P 2222 user@server:/tmp/hello.txt hello.remote.txt
```
2. I have verified the integrity:
```bash
sha256sum hello.txt hello.remote.txt | tee checksums.txt
```
<img width="2884" height="620" alt="Image" src="https://github.com/user-attachments/assets/46e8f2f1-13f3-49af-a004-a868302ba6f3" />

---



