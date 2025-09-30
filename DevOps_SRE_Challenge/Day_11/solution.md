#  My Solution of Day 11 - DevOps/SRE Challenge Series
---

- Today's challenge is totally based on linux filesystem operations(Text file, Logs file, troubleshooting and filtering) to test my hands on + theoritical knowledge. 

- This challenge allows to simulate real world task/operations handled by DevOps/SRE Engineers which gives a good amount of real experience.


## Practical Tasks Setup: Linux Text Avengers Training Camp

I joined the Linux Text Avengers, the elite team responsible for manipulating text files to save the world (or at least your systems).I am ready for a series of challenges that will test my text-fu and prepare myself for any text-based crisis.

---

### 1. Create Your Base of Operations

* Every hero needs a base! So, created my training directory:

```bash
mkdir ~/textlab
cd ~/textlab
```

<img width="3078" height="544" alt="Task1 " src="https://github.com/user-attachments/assets/a2057190-8153-4ed6-8ec7-515c82a369c9" />

---

### 2. The Intelligence File

* My first mission is to analyze an intelligence file. For that I created `myfile.txt` with below vital information:

```bash
cat << EOF > myfile.txt
Line 1: This is a test file. Initializing systems...
Line 2: Administrator access granted. Beware of rogue agents.
Line 3: Memory usage: 500MB. System stable.
Line 4: Error log entry: Unauthorized access attempt detected.
Line 5: IP address: 192.168.1.100. Target server.
Line 6: Password: secret123. DO NOT SHARE.
Line 7: End of file. Mission critical.
EOF
```
<img width="3148" height="888" alt="task2" src="https://github.com/user-attachments/assets/35f13740-25a4-4b84-b9ac-625f3b4cef08" />

---


### 3. Log Simulation: The Enemy's Activity

* Let's simulate enemy activity by creating fake logs. The logs directory will track their actions.

```bash
mkdir ~/textlab/logs
echo "error: disk full. System compromised!" > ~/textlab/logs/log1.log
echo "ERROR: network down. Communications disrupted!" > ~/textlab/logs/log2.log
echo "warning: low memory. System stability threatened!" >  ~/textlab/logs/log3.log
# Make log1.log larger than 1MB to simulate a real log.
for i in {1..10000}; do echo "filler line $i" >> ~/textlab/logs/log1.log; done
```
<img width="3088" height="720" alt="task3" src="https://github.com/user-attachments/assets/58821a1e-ec79-4f99-9b3b-73e8e1131e73" />

---

### 4. System Check

* Before I begin, I have ensured the necessary tools and access.
    * I should be able to read system files like `/etc/passwd` and `/var/log/messages` (some tasks might require sudo).
    * I have installed `mailx` for communication tasks:

```bash
sudo dnf install mailx # Or sudo apt install mailutils on Debian/Ubuntu
```

<img width="3140" height="1020" alt="Image" src="https://github.com/user-attachments/assets/ac7d23a7-d255-4df7-870b-8d9bc2cd621d" />

<img width="3200" height="630" alt="Image" src="https://github.com/user-attachments/assets/c8b326a0-351d-4571-ae0f-9877f7363049" />

---









