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
4. How does `history -c; history -w` differ from `history -c` alone?  
5. Why is `/etc/motd` useful for admins but not GUI users?  

---