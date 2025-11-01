# DevOps + SRE Challenge Series – Season 2
##  Solution - Day 12: The Process Power-Up – Command Your Linux System Like a Pro

This challenge is all about boosting your process management skills for better managing production systems.For this challenge I had used RHEL distro for practical handson.

## Practical Tasks: Operation Server Rescue: Diagnose, Stabilize, and Optimize
As an SRE on call, your task is to diagnose, stabilize, and optimize a production server under heavy load from rogue processes. This guide assumes a Fedora or RHEL system.

### Setup the Crisis

1. **Created a Workspace**:

```bash
mkdir ~/processlab
cd ~/processlab
```

2. **Simulated Server Stress using below**:
    - **CPU-intensive script**:

```bash
echo 'while true; do :; done' &gt; cpu_hog.sh
chmod +x cpu_hog.sh
```

<img width="2186" height="494" alt="Image" src="https://github.com/user-attachments/assets/48e352ae-1b04-4c72-814a-c803f2e5902a" />



    - **Memory-heavy script**:

```bash
echo 'python3 -c "while True: a = [0] * 1000000"' &gt; mem_hog.sh
chmod +x mem_hog.sh
```
<img width="2226" height="512" alt="Image" src="https://github.com/user-attachments/assets/a3fd4040-fc22-416f-8eca-a040068b780c" />


    - **Sleep script**:

```bash
echo 'sleep 3600' &gt; sleeper.sh
chmod +x sleeper.sh
```

<img width="2552" height="370" alt="Image" src="https://github.com/user-attachments/assets/a41eeac1-ab41-476f-845e-062516fadcae" />


3. **I Installed Tools (if needed)**:

```bash
sudo dnf install python3 procps-ng sysstat
```

---

### Task: Stabilize the Server

#### Assess the Load

1. **Check Load Averages**:
Run `uptime` to check load averages and save output to `~/processlab/load.txt`.

```bash
uptime &gt; ~/processlab/load.txt
```

<img width="3178" height="1610" alt="Image" src="https://github.com/user-attachments/assets/d611f1d3-2e93-4a83-b827-cfb3741d2e55" />

---

2. **Note CPU Cores**:
Use `lscpu` to note the number of CPU cores and save to `~/processlab/cpu_info.txt`.

```bash
lscpu &gt; ~/processlab/cpu_info.txt
```
<img width="3178" height="1610" alt="Image" src="https://github.com/user-attachments/assets/f687371a-99a9-4ff9-8b59-960724e14def" />


---

3. **Compared Load to Cores**:
High load (>2 on 2 cores) confirms stress.

#### Survey Running Processes

1. **Listed All Processes**:
Listed all processes with `ps aux`, pipe to `less` for paging, and saved to `~/processlab/all_processes.txt`.

```bash
ps aux &gt; ~/processlab/all_processes.txt
```

<img width="3200" height="1848" alt="Image" src="https://github.com/user-attachments/assets/57a67530-a7b0-4862-9716-8dd3eecea97c" />

---

2. **List Processes Sorted by User**:
Append the list of processes sorted by user to `~/processlab/all_processes.txt`.

```bash
ps aux --sort=user &gt;&gt; ~/processlab/all_processes.txt
```

<img width="3200" height="1866" alt="Image" src="https://github.com/user-attachments/assets/104812ae-dd64-4354-81b8-40d68f919abb" />

---

3. **Show Custom Columns**:
Show custom columns (PID, user, group, VSZ, RSS, command) with `ps -e -o pid,user,group,vsz,rss,comm` and save to `~/processlab/custom_processes.txt`.

```bash
ps -e -o pid,user,group,vsz,rss,comm &gt; ~/processlab/custom_processes.txt
```


#### Launchedd Rogue Processes

1. **Started Background Jobs**:

```bash
./cpu_hog.sh &amp;
./mem_hog.sh &amp;
./sleeper.sh &amp;
```

2. **Start a Foreground Job**:

```bash
./cpu_hog.sh
```

Suspend it with `Ctrl+Z`.

<img width="2896" height="596" alt="Image" src="https://github.com/user-attachments/assets/fdd701ad-698d-4143-96ee-1fffdf0d49b3" />

---

#### Manage Jobs

1. **List Jobs**:
Run `jobs` to list all jobs (expect 3 running, 1 stopped).
2. **Resume Stopped Job**:
Resume the stopped `cpu_hog.sh` job in the background with `bg`.
3. **Bring Job to Foreground and Terminate**:
Bring the first `sleeper.sh` job to the foreground with `fg %1`, then terminate it with `Ctrl+C`.
4. **Confirm Job Removal**:
Check `jobs` to confirm `sleeper.sh` is gone.

<img width="2486" height="1034" alt="Image" src="https://github.com/user-attachments/assets/a666f30e-1944-4e0b-af86-fa25cc5157bd" />

---

#### Monitor in Real-Time

1. **Run Top**:
Run `top`, sort by CPU (P), then memory (M).
2. **Identify mem_hog.sh PID**:
Identify the `mem_hog.sh` PID (high `%MEM`).
3. **Terminate mem_hog.sh**:
In `top`, press `k`, enter the `mem_hog.sh` PID, and send `SIGTERM` (15) to stop it gracefully.
4. **Quit Top**:
Quit `top` with `q`.


<img width="3186" height="1414" alt="Image" src="https://github.com/user-attachments/assets/37347ac4-71d6-4017-a7fc-2167b89f1e41" />

<img width="3192" height="1448" alt="Image" src="https://github.com/user-attachments/assets/e66c282d-087c-48ca-b1ab-92e66c67ebd0" />

<img width="3200" height="1468" alt="Image" src="https://github.com/user-attachments/assets/4bfff97d-884d-4e4d-8da3-b25472a2a82f" />

---

#### Adjust Priorities

1. **Find PID of cpu_hog.sh**:
Find the PID of one `cpu_hog.sh` with `ps aux | grep cpu_hog`.
2. **Set Nice Value to +5**:

```bash
renice 5 -p &lt;PID&gt;
```

3. **Increase Priority to -5**:

```bash
sudo renice -5 -p &lt;PID&gt;
```

4. **Verify Priority Change**:
Verify with `ps -lp &lt;PID&gt;` (check NI column). Save output to `~/processlab/priority.txt`.

```bash
ps -lp &lt;PID&gt; &gt; ~/processlab/priority.txt
```


<img width="1718" height="224" alt="Image" src="https://github.com/user-attachments/assets/61faa279-171e-4b2b-9794-472b8ee30344" />

---

#### Trace Process Hierarchy

1. **Show Process Hierarchy**:
Run `ps fax | grep -B5 cpu_hog` to show `cpu_hog.sh` processes and their parent shell.
2. **Save Hierarchy**:
Save output to `~/processlab/hierarchy.txt`.

```bash
ps fax | grep -B5 cpu_hog &gt; ~/processlab/hierarchy.txt
```


#### Clean Up Stragglers

1. **Start Another Rogue Process**:
From a second terminal, start another rogue process:

```bash
./cpu_hog.sh &amp;
exit
```


2. **Confirm Process Running**:
Back in the first terminal, use `ps aux | grep cpu_hog` to confirm it’s still running.
3. **Terminate All cpu_hog.sh Processes**:

```bash
killall -15 cpu_hog.sh
```

4. **Verify Termination**:
Verify with `ps aux | grep cpu_hog` (no results).


<img width="2406" height="1040" alt="Image" src="https://github.com/user-attachments/assets/792dc70f-2090-43e7-a6f9-32fe96bab068" />

#### Final Sweep

1. **Check Load Again**:
Check load again with `uptime`. Append to `~/processlab/load.txt`.

```bash
uptime &gt;&gt; ~/processlab/load.txt
```

2. **Force-Stop Remaining Processes**:
If load is still high, use `killall -9 sleeper.sh` to force-stop any remaining processes.
3. **Save Final Processes**:
Save final `ps aux` output to `~/processlab/final_processes.txt`.

```bash
ps aux &gt; ~/processlab/final_processes.txt
```


<img width="3200" height="1904" alt="Image" src="https://github.com/user-attachments/assets/81c86745-39dd-4ddd-84e2-bb88f8eeb972" />

#### Document Findings

In `~/processlab/notes.txt`, document:

- Which process caused the most stress (`cpu_hog.sh` or `mem_hog.sh`).
- How load changed after cleanup.
- One lesson learned (e.g., “`SIGTERM` is safer than `SIGKILL`”).


<img width="2744" height="1060" alt="Image" src="https://github.com/user-attachments/assets/045a4cf1-9423-400f-bc10-3bfd3db7c924" />



