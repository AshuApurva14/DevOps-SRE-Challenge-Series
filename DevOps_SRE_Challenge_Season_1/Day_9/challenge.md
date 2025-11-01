# Day 9: Mastering the Linux Shell
## 4️⃣ Challenge Breakdown  

### **📝 Theoretical Questions**  
1. How does the shell bridge applications and the kernel?  
2. Explain `2>&1` vs. `2> file` with an example.  
3. Why does `myscript` fail but `./myscript` work?  
4. How does `history -c; history -w` differ from `history -c` alone?  
5. Why is `/etc/motd` useful for admins but not GUI users?  

---

### **⚙️ Practical Challenge: Shell Skills in Action**  

#### **Step 1: Shell & Redirection on EC2 Instances**  
**Goal:** Master commands and I/O on Day 1 EC2s (Ubuntu, Amazon Linux, RHEL).  

1. SSH into each:  
```
   ssh -i mykey.pem ubuntu@<public-ip>      # Ubuntu
   ssh -i mykey.pem ec2-user@<public-ip>    # Amazon Linux
   ssh -i mykey.pem ec2-user@<public-ip>    # RHEL
```

2. Run these:
```
type ls                   # Alias or binary?
ls -l /etc > out.txt      # Redirect STDOUT
ls nofile 2> err.txt      # Redirect STDERR
cat out.txt err.txt > combined.txt 2>&1  # Merge outputs
echo "Host: $(hostname)" >> combined.txt  # Append
ls -R / | grep "bin" | less  # Pipe chain
history -d 2              # Delete 2nd command
```

3. Capture combined.txt content.
**Troubleshooting Tip:** ls: command not found? Check $PATH with echo $PATH.
```bash
#!/bin/bash
REPORT="sys_$(date +%Y%m%d).txt"
echo "Check - $(date)" > "$REPORT"
echo "User: $USER" >> "$REPORT"
uptime -p | tee -a "$REPORT"  # Pipe and append
df -h / | tail -n 1 >> "$REPORT" 2>/dev/null
```

#### **Step 2: Vim & Scripting on RHEL VM**
**Goal:** Edit and automate with Vim on your Day 1 RHEL VM.

1. Boot RHEL VM, log in.
2. Create/edit a script:
```
vim ~/monitor.sh
```

3. Input (press i):
```
#!/bin/bash
REPORT="sys_$(date +%Y%m%d).txt"
echo "Check - $(date)" > "$REPORT"
echo "User: $USER" >> "$REPORT"
uptime -p | tee -a "$REPORT"  # Pipe and append
df -h / | tail -n 1 >> "$REPORT" 2>/dev/null
```

4. Edit: Esc, :3 (line 3), dd (delete), u (undo), :wq (save+quit).
5. Run:
```
chmod +x monitor.sh
./monitor.sh
cat "$REPORT"
```

6. Persist an alias:
```
echo "alias m='./monitor.sh'" >> ~/.bashrc
source ~/.bashrc
```

**Pro Tip:** Vim stuck? Esc, :q! forces exit!
