# DevOps/SRE Challenge Day 10 - Solution
## Challenge - The Filesystem Heist


### Challenge Description
You’re securing a server after a botched update. Your mission: navigate the filesystem, manage critical files, secure a new storage vault, collaborate with agents, and archive secrets—all while leaving no trace. Ready?

## Theory Questions
Answers of Theoritical questions can be found at below link:

[theory_answer.md](/workspaces/DevOps-SRE-Challenge-Series/DevOps_SRE_Challenge/Day_10/theory_answers.md)

---

### II. Practical

### Task 1: Infiltrating the Filesystem (as `ec2-user`)

- My entry point with `pwd` (expect `/home/ec2-user`).
- Infiltrate `/var/log` using an absolute path.
- Retreat to `/var` with a relative move.
- Slip back to base (`~`) using a shortcut.
- In one command, hit `/tmp` then bounce back to base, verifying with `pwd`.

 <img width="3200" height="1418" alt="task1" src="https://github.com/user-attachments/assets/6103b024-2bb0-4975-bcbe-1c048084adff" />

 ---

### Task 2: Set Up the Hideout (as `ec2-user`)
- Establish `heist_vault` in `~`.
- Create subdirs `newfiles` and `oldfiles` in one command.
- In `newfiles`, plant a hidden file `.secret` and a decoy `decoy.txt` using `touch`.
- Secure `newfiles` with `chmod 700` and verify with `ls -ld`.

<img width="2716" height="1784" alt="Image" src="https://github.com/user-attachments/assets/d0b22e46-94b6-45d4-885e-a62a147432c8" />

---


### Task 3: Secure the New Vault - Storage Management (Root)
- **Agent Brief**: A new 1GB EBS volume arrives (or simulate with a loop device).
  1. As root: If on AWS, attach a 1GB EBS volume via the console; note the device (e.g., `/dev/xvdf`). If not, create a 1GB loop device: `dd if=/dev/zero of=/root/disk.img bs=1M count=1000; losetup /dev/loop0 /root/disk.img`.
  2. Partition it: `fdisk /dev/xvdf` (or `/dev/loop0`) → `n` (new), `p` (primary), `1` (partition 1), defaults, `w` (write).
  3. Format as ext4: `mkfs.ext4 /dev/xvdf1` (or `/dev/loop0p1`).
  4. Mount at `/data`: `mkdir /data; mount /dev/xvdf1 /data` (or `/dev/loop0p1`).
  5. Verify: `df -h` (shows `/data` usage) and `lsblk` (lists device tree).
- **Tip**: If `lsblk` shows no partitions, recheck `fdisk` steps.

<img width="3200" height="1878" alt="task3" src="https://github.com/user-attachments/assets/cd08e508-fb75-40ab-b9dd-58a67ec8d683" />

---

### Task 4: Advanced File Ops Under Pressure (as `ec2-user`)
- From `heist_vault/oldfiles`:
  1. Copy `newfiles` (including `.secret`) into `oldfiles` with `cp -a ../newfiles/ .`.
  2. Remove the nested `newfiles` with `rm -rf newfiles`.
  3. Copy only visible files from `../newfiles` using `cp -a ../newfiles/* .`.
  4. Copy hidden files separately with `cp -a ../newfiles/. .` and verify with `ls -a`.
- In `~`:
  5. Create `projects` with `house1` to `house9` using brace expansion.
  6. List only `house*` files (exclude others like `heist_vault`).
  7. Build `$HOME/projects/houses/doors/` and plant:
     - `$HOME/projects/houses/bungalow.txt`
     - `$HOME/projects/houses/doors/bifold.txt`
     - `$HOME/projects/outdoors/vegetation/landscape.txt`
  8. Copy `house1` and `house5` to `houses/`.
  9. Recursively copy `/usr/share/doc/initscripts*` to `projects/` with `-a`.
  10. List `projects/` recursively, paging with `less`.
  11. Wipe `house6` to `house8` non-interactively.
  12. Move `house3` and `house4` to `doors/`.
  13. Obliterate `doors/` and its contents.
  14. Set `house2` perms to owner `rw`, group `r`, others none.
  15. Recursively block write access to `projects/` for all.


<img width="3200" height="1912" alt="task4_1" src="https://github.com/user-attachments/assets/1341f7bb-09e3-4420-9d38-1fd29b35e7af" />

<img width="3194" height="1880" alt="Image" src="https://github.com/user-attachments/assets/b457f73e-608b-4ee1-9725-e0d417e379df" />

---

### Task 5: Agent Collaboration (Root + Users)
- As root:
  1. Create group `agents`.
  2. Add users `alice` and `bob` to `agents` with home dirs and passwords.
  3. Establish `/data/shared_space`.
  4. Assign group `agents` with `chgrp`.
  5. Set perms to `770`.
  6. Enable SGID with `chmod g+s`.
- As `alice`: Create `alice_file.txt` in `/data/shared_space`.
- As `bob`: Create `bob_file.txt` in `/data/shared_space`.
- Verify: `ls -l` shows both files group-owned by `agents`.




### Task 6: Cover Your Tracks with Links (as `ec2-user`)
- In `~`:
  1. Try hard-linking `/etc/passwd` to `passwd_hard` (expect denial).
  2. Soft-link `/etc/passwd` to `passwd_link`.
  3. Soft-link `/etc/hosts` without a target dir (default to current dir).
- In `heist_vault`:
  4. Create `evidence.txt`.
  5. Hard-link it to `evidence_copy` and check link count with `ls -l`.
  6. Soft-link it to `evidence_sym`.
  7. Delete `evidence.txt`.
  8. Test `cat evidence_sym` (broken) and `cat evidence_copy` (works).
  9. Restore `evidence.txt` from `evidence_copy` with `ln`.
  10. Verify with `ls -l`.

  

<img width="3200" height="1770" alt="Image" src="https://github.com/user-attachments/assets/366d62f4-5e81-47c9-85c6-043fe2c37997" />

---

### Task 7: Archive the Loot (Root)
- As root:
  1. Archive `/etc` to `/root/etc.tar` (uncompressed).
  2. Check type with `file`.
  3. Compress to `etc.tar.gz` with `gzip`.
  4. List contents with `tar tvf`.
  5. Extract `/etc/hosts` to `/root`.
  6. Verify with `ls -R /root/etc/`.
  7. Decompress `etc.tar.gz`.
  8. Extract `/etc/passwd` to `/tmp` with dir structure.
  9. Confirm with `ls -l /tmp/etc/passwd`.
  10. Create bzip2 archive of `/home` as `/root/homes.tar.bz2`.
  11. Clean up archives from `/root`.


  <img width="3200" height="1232" alt="Image" src="https://github.com/user-attachments/assets/8c39d3e4-677b-4e45-8fee-c229a069e916" />

---

### Task 8: Root Shell Heist (as `student` → Root)
- As `student`:
  1. Escalate to root with `sudo -i`.
  2. Archive `/home` and `/etc` to `/root/essentials.tar`.
  3. Copy to `/tmp`.
  4. Hard-link it to `/essentials.tar`.
  5. Rename to `/archive.tar`.
  6. Soft-link from `/root/link.tar` to `/archive.tar`.
  7. Delete `/archive.tar` and observe `link.tar`.
  8. Remove `link.tar`.
  9. Compress `/root/essentials.tar` to `.gz`.

  <img width="3200" height="670" alt="Image" src="https://github.com/user-attachments/assets/a0f4bfae-7551-4698-bea4-ea7a9a257753" />

---



## Best Practices and Tips

- Ensure the destination directory exists to avoid creating a file instead of copying into a directory.

- Use the -a option when you want to preserve file attributes like permissions and timestamps.

- Be cautious when using wildcards, and always double-check your command before executing to avoid unintended consequences.

