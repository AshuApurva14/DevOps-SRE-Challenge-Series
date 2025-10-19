# Day 16 - Solution
# OSI Layer 1 & 2 – Physical and Data Link – Interfaces, MAC, ARP, VLAN

## "Getting Connected: Cables, Cards, and Local Communication"



### Guided Hands-On: Local, Cloud, and VirtualBox

### A. Local or VM Interface Basics

I have tested and executed the below comamnd in my local to check how network interface and MAC address looks like.

1. **List all interfaces & MAC addresses**
    ```bash
    ip link show
    ```
    - Below you can see how the network interface and MAC address looks like:

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

<img width="2304" height="874" alt="Image" src="https://github.com/user-attachments/assets/2f30c16c-e513-486e-8725-b43481f7577b" />

---

### B. Cloud Scenario: AWS/GCP/Azure

**Scenario:**  
You have two cloud VMs in the same subnet. They cannot ping each other.  
- Both have IPs in the correct range and interfaces marked UP.
- Both have unique MAC addresses.
- ARP tables on both show the other’s IP as “INCOMPLETE”.

Below screenshot can help you understand the problem statement easliy.


**Questions:**  
1. What might cause this in cloud environments? (Hint: Security Groups, NACLs, subnet config, ENI not attached)

    - It is due to Security group does not have ICMP rule allowed in both the Cloud VMs.

---

2. What console/CLI checks should you try?

    - First, I will check the Security group rules for the both the VMs, if ICMP rule is allowed or not.
    - If the rules are not added then I will add ICMP rule (IP of one VM into other security group and vice-versa) in the security group of both the VMs.

  <img width="3205" height="844" alt="Image" src="https://github.com/user-attachments/assets/a6b95a1a-fa93-4a42-8e47-822229374f69" />

---

3. What Linux commands confirm interface/MAC status?

   - To check the status of interface/MAC use below commands
   
    ```bash
     ip addr show

     ip link show <interface>
    ``` 

    <img width="2396" height="1286" alt="Image" src="https://github.com/user-attachments/assets/3c3a301d-5b52-467f-a660-3388ad140228" />


After, enabiling ICMP Rule in both VMs security group, `ping` started to work.

<img width="1960" height="696" alt="Image" src="https://github.com/user-attachments/assets/2c1fb782-6f47-43ea-8ef2-a42637df71a0" />

<img width="1988" height="716" alt="Image" src="https://github.com/user-attachments/assets/69b89066-831f-48e1-90d4-d3874dff72fc" />

---

### C. VirtualBox Scenario

**Scenario:**  
You clone a VM in VirtualBox, but networking is broken:
- `ip addr` shows an IP
- `ip link show` shows interface DOWN, or both VMs have the same MAC

**Questions:**  
1. What Layer 1/2 issues can happen when cloning a VM?

    - Cloning VM can lead to Layer 1/2 issues related to duplicate hardware identifier and network configurations.
    - Below are the list of common issue occurs while cloning:

      - Duplicate MAC Addresses
      - Duplicate IP Addresses
      - Linux network interface renaming
      - Windows System Identifier (SID) and KMS issue.

    
2. How can you fix these in VirtualBox settings and on the VM?

   - To fix **Duplicate MAC Address** issue, I will generate a new MAC.
   - Remove and Readd the vNIC.

   - To fix **Duplicate IP Address**issue, I will first used DHCP and manually reconfigure network settings.
   

3. What commands would you use to verify?
   
   To verify below commands can be used:

   - Check MAC address `ip link show`.
   - Check network interface status `ip addr show`
   

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

## ARP Log Analysis: Mini Incident Simulation

A real world incident simuation challenge.

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

**Hands-on tasks:**
1. What does the ARP entry “INCOMPLETE” mean?

    - The ARP entry "INCOMPLETE" means the VM has sent an ARP request for IP Address 10.10.10.1 which is its gateway.
    - But has not yet received a reply with the corresponding MAC Address.
    - The system puts this entry in its ARP cache as a placeholder and will repeatedly re-send the ARP request until it receives a response or times out.
  

2. List two possible causes for this on physical, VirtualBox, or cloud VMs.

   Below are the two possible cause:

    1. Network device or connectivity issue (Physical/Virtual Layer 1 or 2)
        - Physical or Virtual NIC Failure
        - Switch Configuration error
        - External gateway or firewall error

    2. Incorrect network configuration (Virtual Layer 2 or 3)

        - IP address misconfigurations
        - Misconfigured virtual network

3. What troubleshooting steps would you take to fix it, layer by layer?

   Troubleshooting steps (Layer-by-layer):

   - Layer 1: Physical and virtual connectivity 

     1. Check VM state: Verify that the VM is powered on and its network adapter is connected in the hypervisor's settings (e.g., VirtualBox, vSphere).

     2. Verify hypervisor network: Check the network configuration on the hypervisor host to ensure the virtual network switch is correctly configured and the VM is attached to the right network.

     3. Inspect switch/port status: Check the status of the physical switch port connected to the hypervisor host. The port status should be "UP/UP".

     4. Confirm VM visibility (cloud): For cloud environments (like Azure, AWS), verify the virtual network interface and associated security group settings in the cloud management console. 

   - Layer 2: Data Link Layer

     1. Check for MAC address conflicts: Ensure no other device on the network has the same IP address (10.10.10.5) or MAC address (52:54:00:ab:cd:ef).

       In a VM clone scenario, this is a common issue. Check the clone's settings to confirm it has a unique MAC address.

     2. Use packet capture (tcpdump): Run tcpdump -i eth0 arp on the VM to see if ARP requests for 10.10.10.1 are being sent out and if any replies are received.

       Run tcpdump on the gateway or an adjacent network device to check if the ARP requests from the VM are arriving and if the ARP replies are being sent back.

     3. Inspect VLAN configuration: If the network uses VLANs, confirm that the VM's virtual network interface and the gateway's interface are on the same VLAN. 


   - Layer 3: Network Layer

    1. Check IP and gateway configuration: Verify that the VM's IP address (10.10.10.5) and subnet mask (/24) are correct and that the gateway's IP address (10.10.10.1) is also correct. Check if the gateway is actually configured at 10.10.10.1.

    2. Verify routing table: The ARP INCOMPLETE entry is for the gateway. Check the VM's routing table (ip route show) to ensure the default route points to 10.10.10.1 and that there are no conflicting routes.

    3. Check firewall rules:
     Inspect firewall rules on the VM (iptables, firewalld) and any external firewalls or security groups (in the case of cloud VMs) to ensure they are not blocking ARP traffic.

    4. Ensure the gateway or other devices on the network are not using ARP attack detection features that are dropping the VM's ARP requests


   - Layer 4: Application Layer

    1. Test gateway reachability from another device: From another machine on the same network segment, attempt to ping the gateway (ping 10.10.10.1). If this fails, the issue is with the gateway or the network infrastructure, not the VM.

    2. Reset network interfaces: If the above steps fail, try restarting the VM or restarting the network interfaces.
   ```bash
    sudo ip link set dev eth0 down && sudo ip link set dev eth0 up

   ```

    3. For a clone, completely re-adding the network adapter in the hypervisor might be necessary.



---

## Key Takeaways

 - Ensure proper network configurations on Physical, Virtual or Cloud based environments.
 
 - It is very crucial to enough resources are available to successfully setup and configure each of network devices physical or virtual.
