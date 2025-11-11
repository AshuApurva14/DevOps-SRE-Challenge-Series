## Theory Answers


1. **Filesystem Hierarchy**: What is the purpose of the `/var` directory, and why might it be mounted on a separate device?

   - The /var directory in linux file system is serves as repository for variable data file.These are files that are expected to grow in size or change their data during normal file operation of the system.

   - The /var directory holds dynamic information such as logs (/var/log), mail, or runtime files.

   - It must be mounted to separate device to prevent unwanted filing up of root filesystem and crashing runnig services.


2. **Paths**: Explain the difference between an absolute path and a relative path. Give an example of each that reaches `/home/user/docs` from `/usr/share`.

   In Linux, paths are used to locate files and directories in file system.There are two main types of paths: absolute and relative.

   **Absolute Path:**

   - An absolute path specifies the complete location of a file or directory starting from the root directory (/).

   - It provides an unambiguous and fixed reference to a resource, regardless of the current working directory.

   - Example: For reaching to '/home/user/docs' from 'usr/share' you must do below step

 ```bash
      #This is the absolute path you follow.
      cd /home/user/docs 
```

   **Relative Path:**
    
   - A relative path specifies the location of a file or directory in relation to the current working directory.

   - It provides a flexible way to reference resources within the immediate context of the user's current location. 
 
   - Example: 
     For reaching to '/home/user/docs' from 'usr/share' you must do below step

```bash
       # This is the relative path you follow.
       cd ~/user/docs
```
---

3. **Wildcards**: If you run `ls f[io]le*` in a directory containing `file1`, `fole2`, `file3`, and `flea`, what files will be listed?


    - If you run 'ls f[io]le* in a directory containing 'file1', 'fole2', 'file3' and 'flea' it will list below files:
     
```bash

   
   $ ls f[io]le*
   $ file1
   $ fole
```


---

4. **Permissions**: What does `chmod 640 file.txt` do to the permissions of `file.txt`? Describe the resulting access for owner, group, and others.

 
  - The command `chmod 640 file.txt` will add read,write and no permissions to file.txt.

  - As, a result Owner of the file will have read and write permissions to file.txt.

  - Group will have only read permissions to file.txt. Others will have no permission to file.txt.



---



5. **Mounts**: Why might an administrator mount `/home` with the `noexec` option? What does this prevent?

- The `noexec` option is a powerful tool that can enhance the security of your Linux environment by preventing the execution of programs from specific file systems.

- Why might ana dmin mount /home with `noexec` option:
   
    - Security Enhancements: It prevents user from executing potentialy malicious and unauthorized executables from their home directory.

    - Reducing Risk from Untrusted Sources.


---


6. **Copying Files**: How does `cp -a /dir1 /dir2` differ from `cp -r /dir1 /dir2` when copying a directory?


   - `cp -a /dir1 /dir2 ` and `cp -r /dir1 /dir2` command recursively copy directory all files and subdirectories from /dir1 and /dir2, even hidden file as well. 

   - The key difference is that `cp -a` preserves.
   
  
---

7. **Links**: What’s the difference between a hard link and a symbolic link? Why might a hard link to `/etc/passwd` fail when created in your home directory?

   | Feature             | Hard Link                                                        | Symbolic(Soft) Link                                                                 | 
   |---------------------|------------------------------------------------------------------|-------------------------------------------------------------------------------------|
   | Pointer to file     |Points directly to the file's data (inode).                       |Points to the file's name or path.                                                   |
   | Inode               |Shares the same inode number as the original file.                |Has its own unique inode number.                                                     |
   | Cross File System   |	Cannot cross different file systems.                             | 	Can link to files across different file systems.                                  | 
   | Deletion of Original|The link still works, as it points to the data, not the filename. |The link breaks (becomes a "dangling link") if the original file is moved or deleted.|
   |                     |The data is only deleted when the last hard link is removed.      |                                                                                     |
   | Directories         |	Cannot be created for directories.                               |  	Can be created for directories.                                                   |
   | Disk Space          |Uses a negligible amount of space for the directory entry.        |Requires a small amount of disk space to store the path to the original file.        |



---


8. **Redirection**: What does `echo "Log entry" >> /var/log/mylog` do? How is it different from using `>`?


    - The command echo "Log entry" >> /var/log/mylog appends the text "Log entry" as a new line to the end of the file /var/log/mylog.

    - It is different from `>` as it wil overwrite the conetnt of the file.


---


9. **Mount Commands**: Compare the output of `mount`, `df -h`, and `findmnt`. Which would you use to check available disk space?


     <img width="1148" height="932" alt="Image" src="https://github.com/user-attachments/assets/069ab980-89e0-4524-9f0f-9dd4addff753" />


     - To check disk sapce use `df -h`. As, it wil provide details on human readable format compare to other options.

---

10. **SGID**: What happens to the group ownership of files created in a directory with the SGID bit set (e.g., `chmod g+s`)?

    When the SGID (Set Group ID) bit is set on a directory using chmod g+s, any new files or subdirectories created within that directory will inherit the directory's group ownership.

---






