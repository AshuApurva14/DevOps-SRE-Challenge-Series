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




5. **Mounts**: Why might an administrator mount `/home` with the `noexec` option? What does this prevent?
6. **Copying Files**: How does `cp -a /dir1 /dir2` differ from `cp -r /dir1 /dir2` when copying a directory?
7. **Links**: What’s the difference between a hard link and a symbolic link? Why might a hard link to `/etc/passwd` fail when created in your home directory?
8. **Redirection**: What does `echo "Log entry" >> /var/log/mylog` do? How is it different from using `>`?
9. **Mount Commands**: Compare the output of `mount`, `df -h`, and `findmnt`. Which would you use to check available disk space?
10. **SGID**: What happens to the group ownership of files created in a directory with the SGID bit set (e.g., `chmod g+s`)?




