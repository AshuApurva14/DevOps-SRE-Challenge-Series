### **📝 Theoretical Questions**  
1. How does the shell bridge applications and the kernel? 

   - Shell acts as bridge between applications and kernel. It provides a user friendly interface (like command-line interpreter) to interact with Kernel and translating user commands into system calls.

   - The shell is a convenience layer that allows users and applications to send requests to the kernel without needing to directly interact with the complex and privileged operations that the kernel performs. 

2. Explain `2>&1` vs. `2> file` with an example. 

   Linux provides three types of  standard streams:

   - **Standard Output (stdout):** Represented by file descriptor 1. This is for a program's normal, expected output.
   - **Standard Error (stderr):** Represented by file descriptor 2. This is for error messages and diagnostic information.
   - **Standard Input (stdin):** Represented by file descriptor 0. This is for a program's input. 

---

   ***In the shell, 2>&1 and 2> file are used for output redirection, but they have distinct purposes.***

   - **2>** file redirects only the standard error (stderr) stream to a specified file.
   - **2>&1** is a command that redirects the standard error (stderr) stream to the same location as standard output (stdout). To send both streams to a file, 2>&1 is typically combined with a standard output redirection (> or >>). 

---
  *2> file:* **Redirecting only standard error**
     ----------------------------------------------

   - **Example:** Imagine a script named check_files.sh that checks for the existence of two files.

   **check_files.sh**

```bash
    ls existing_file.txt
    ls non_existing_file.txt

```

   This command redirects only standard error to error.txt. 

```bash
    ls  existing_file.txt 2> error.txt
    ls non_existing_file.txt 2> error.txt

```

   The error.txt file will contain only the error message:
```bash
    ls: cannot access 'file-not-found': No such file or 

```
---

  **combined.txt 2>&1:**
  ----------------------

  - This command first redirects standard output (>) to combined.txt, then redirects standard error (2>&1) to the same place as standard output. 

  ```bash
    ls file1.txt file-not-found > combined.txt 2>&1

  ```
  - The combined.txt file will contain both the normal output and the error message:
  
**file1.txt**
```bash
ls: cannot access 'file-not-found': No such file or directory

```


3. Why does `myscript` fail but `./myscript` work?  

   **Why myscript fail?**

   - The file `myscript` execution fail because system could able to find the executable file, as it is not in the current directory or the System PATH enviornment variable.
  
   **Why ./myscript works**

   - Current Directory Specification: The ./ (dot slash) is a shorthand that explicitly tells your operating system to look for the executable file in the current directory.

   - Direct Execution: This tells the system, "Look in the directory I am currently in for a file named myscript and run it".

---

4. How does `history -c; history -w` differ from `history -c` alone?  

   **The primary difference between history -c and history -cw is that -c only clears the command history from the current shell's memory, while -cw clears it from both memory and the history file on disk.**


---

5. Why is `/etc/motd` useful for admins but not GUI users? 

  - The /etc/motd (message of the day) file is useful for system administrators but not for graphical user interface (GUI) users because it is displayed only when a user logs in via a text-based interface, such as a terminal or SSH.
  -  A typical GUI session, which bypasses the standard login shell, does not display these messages to the end-user. 

---

### **⚙️ Practical Challenge: Shell Skills in Action**  


#### **Step 1: Shell & Redirection on EC2 Instances**  
**Goal:** Master commands and I/O on Day 1 EC2s (Ubuntu, Amazon Linux, RHEL). 

1. SSH into EC2 instance(created previously on Day 8)

   After Login into each of the  3 EC2 instances, run the below commands:
```bash
type ls                   # Alias or binary?
ls -l /etc > out.txt      # Redirect STDOUT
ls nofile 2> err.txt      # Redirect STDERR
cat out.txt err.txt > combined.txt 2>&1  # Merge outputs
echo "Host: $(hostname)" >> combined.txt  # Append
ls -R / | grep "bin" | less  # Pipe chain
history -d 2              # Delete 2nd command

```

   - Let's execute in **Ubuntu 22.04 LTS Distro:**

   <img width="3192" height="444" alt="ubuntu_shell" src="https://github.com/user-attachments/assets/fdf90e6a-cfdd-4e85-b6e7-f936300693e6" />

   - **After execution of above comamnds, 3 files gets created: out.txt, err.txt and combined.txt**

   - **cat combined.txt**

   <img width="3200" height="1904" alt="ubuntu_combined.txt" src="https://github.com/user-attachments/assets/471a0c4c-7afe-41d5-8bcb-8c67e01dbdd5" />


   - 




