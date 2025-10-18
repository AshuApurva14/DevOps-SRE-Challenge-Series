# Day 16 - Solution
# OSI Layer 1 & 2 – Physical and Data Link – Interfaces, MAC, ARP, VLAN

## "Getting Connected: Cables, Cards, and Local Communication"



### Guided Hands-On: Local, Cloud, and VirtualBox

### A. Local or VM Interface Basics

1. **List all interfaces & MAC addresses**
    ```bash
    ip link show
    ```
    - Primary network interface and note its MAC.

    

    

2. **Is your interface up?**
    ```bash
    ip link show <interface>
    ```
    - If not, bring it up:
    ```bash
    sudo ip link set <interface> up
    ```

3. **Check statistics**
    ```bash
    ip -s link show <interface>
    ```
    - Look for dropped or error packets.

---

### B. Cloud Scenario: AWS/GCP/Azure

**Scenario:**  
You have two cloud VMs in the same subnet. They cannot ping each other.  
- Both have IPs in the correct range and interfaces marked UP.
- Both have unique MAC addresses.
- ARP tables on both show the other’s IP as “INCOMPLETE”.

**Questions:**  
1. What might cause this in cloud environments? (Hint: Security Groups, NACLs, subnet config, ENI not attached)

    - It is due to Security group does not have ICMP rule allowed in both the Cloud VMs.
---

2. What console/CLI checks should you try?

    - First, I will check the Security group rules for the both the VMs, if ICMP rule is allowed or not.
    - If the rules are not added then I will add ICMP rule (IP of one VM into other security group and vice-versa) in the security group of both the VMs.

---

3. What Linux commands confirm interface/MAC status?

   - To check the status of interface/MAC use below commands
   
    ```bash
     ip addr show

     ip link show <interface>
    ``` 

---

### C. VirtualBox Scenario

**Scenario:**  
You clone a VM in VirtualBox, but networking is broken:
- `ip addr` shows an IP
- `ip link show` shows interface DOWN, or both VMs have the same MAC

**Questions:**  
1. What Layer 1/2 issues can happen when cloning a VM?
2. How can you fix these in VirtualBox settings and on the VM?
3. What commands would you use to verify?

---

### D. VLANs – (Optional/Conceptual)

> **Note:**  
> True VLAN separation isn’t possible in plain VirtualBox setups without advanced config or special hardware/software switches.  
> You can create VLAN interfaces in Linux for practice, but isolation won’t occur.

- **Task:** Draw a diagram: Two VLANs (10 and 20) on the same switch—who can talk to whom?
- Try to create a VLAN interface on a Linux VM (if supported):
    ```bash
    sudo ip link add link <interface> name <interface>.10 type vlan id 10
    sudo ip link set <interface>.10 up
    ip link show
    ```

---

## 5. ARP Log Analysis: Mini Incident Simulation

You receive these logs from a VM with network issues:

```
$ ip link show eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:ab:cd:ef brd ff:ff:ff:ff:ff:ff

$ ip addr show eth0
    inet 10.10.10.5/24 brd 10.10.10.255 scope global eth0

$ ip neigh show
10.10.10.1 dev eth0 INCOMPLETE
```

**Your tasks:**
1. What does the ARP entry “INCOMPLETE” mean?
2. List two possible causes for this on physical, VirtualBox, or cloud VMs.
3. What troubleshooting steps would you take to fix it, layer by layer?

---