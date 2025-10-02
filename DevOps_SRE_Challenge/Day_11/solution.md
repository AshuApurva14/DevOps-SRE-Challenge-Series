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

## Operation: Text Manipulation

### Original Tasks: Core Skills Training

  

1. **Decoding the Intelligence:** Show line 5 from `~/textlab/myfile.txt` using two different methods. What does this IP address represent?

   <img width="3180" height="418" alt="Image" src="https://github.com/user-attachments/assets/54a1ff70-645b-44b8-8522-c12d2b033e0f" />

   - Here, I.P Address represents Target Server IP.

---

2. **Hunting the Target:** Locate text files in `~/textlab` containing `"192.168.1.100"`. Is a regex needed for this simple search?

   <img width="2950" height="298" alt="Image" src="https://github.com/user-attachments/assets/f30b1dda-36cc-442e-b1d2-352b0bb9da2d" />
   
   - Here, regex is required to filter the file with specific IP Address.

---

3. **Reversing the Sabotage:** A rogue agent changed `"Administrator"` to `"root"` in `~/textlab/myfile.txt` using `sed`. Can you undo this sabotage *without* a backup?

   - Here, I have undo the changes done on the file `~/textlab/myfile.txt` using sed.

    <img width="3182" height="764" alt="Image" src="https://github.com/user-attachments/assets/61fd4e66-868f-4f08-a1b8-0b19e55b1daa" />

---


4. **Memory Optimization:** Sort `myfile.txt` lines, simulating system performance by putting the largest memory value first (based on line 3). This tests ability to analyze numerical info within text.

<img width="2842" height="636" alt="Image" src="https://github.com/user-attachments/assets/a28a0e58-8568-4ad6-8bcf-c3a10dc2cd89" />

---

5. **System Recon:** Extract the sixth column from `ps aux` to understand system usage. (This is a unchanged recon mission, unrelated to the rest of this scenario).

<img width="3162" height="1514" alt="Image" src="https://github.com/user-attachments/assets/5b2602a5-9d43-4d29-b24e-0cf7bd1ac86d" />

---

6. **Deleting Sensitive Info:** Remove the potentially compromised "Password" line (line 6) from `~/textlab/myfile.txt`.

<img width="2390" height="878" alt="Image" src="https://github.com/user-attachments/assets/3ee8c853-8be2-4605-a459-f84655bcad1d" />

---

### Additional Interesting Tasks: Advanced Missions

1. **Swapping Intel:** Swap lines 3 and 4 in `~/textlab/myfile.txt` using `vi/vim` to reorganize mission-critical info.


<img width="2044" height="1900" alt="Image" src="https://github.com/user-attachments/assets/b4130d65-6a09-412f-9b90-d093d85eaa0c" />



<img width="1892" height="1796" alt="Image" src="https://github.com/user-attachments/assets/6116a2b9-6a9c-4b7f-95ad-703a5c63bda4" />

---

2. **Archiving Enemy Logs:** Find all `.log` files larger than 1MB under `~/textlab/logs`, and archive them to a `.tar.gz` in `~/textlab` for analysis. Think of this step as containing damage after an attack.

<img width="2854" height="1018" alt="Image" src="https://github.com/user-attachments/assets/08a44e8d-9e7d-4117-bcc6-97b9c239fa93" />

---

3. **Finding Patterns:** Use `grep`, `sort`, and `uniq` to count unique words with `"error"` (case-insensitive) in `~/textlab/logs/log1.log`. What does that data signify about system stability?

<img width="2380" height="356" alt="Image" src="https://github.com/user-attachments/assets/5ccefd07-6829-49c9-9a37-b7c6ae9097d2" />

---

4. **Alerting the Team:** Search `~/textlab` for `"password"`, highlight it in color, and email this vital alert to yourself using `mail`. (Configure `mail` first if you haven't done so)

## Best Practices and Tips

 - Ensure proper access and permission is provided for successful execution of the commands and operations.