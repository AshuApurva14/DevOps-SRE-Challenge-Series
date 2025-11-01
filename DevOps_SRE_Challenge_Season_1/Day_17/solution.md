# Solution of Day 17 - DevOps SRE Challenge Season 2

This is my full guide solution for the given problem statements. Please feel free to correct anywhere it is required.

Let's solve this guide hands on.

##  **Guided Hands-On Lab: Become Your Own Router**

### **Lab Setup (VirtualBox/VMware)**
1. Create **three** VMs.
2. Set their network adapters to **Internal Network** (e.g., `LAB_NET`).
3. Boot them up (they’ll have no IP initially).

### **Step 1: Configure the "Router"**
On VM1 (`router`):
```bash
sudo ip addr add 192.168.10.1/24 dev enp0s3
sudo ip addr add 192.168.20.1/24 dev eth1
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

### **Step 2: Configure the "Clients"**
On VM2 (`client-a`):
```bash
sudo ip addr add 192.168.10.10/24 dev eth0
sudo ip route add default via 192.168.10.1
```
On VM3 (`client-b`):
```bash
sudo ip addr add 192.168.20.20/24 dev eth0
sudo ip route add default via 192.168.20.1
```

### **Step 3: Test the Connectivity**
From `client-a`:
```bash
ping 192.168.20.20
```
- If it works: you built a routed network! The router VM forwards between subnets.

---

##  **Layer 3 in Action – App, Proxy, & Load Balancer Troubleshooting**

### **Mini Project: How Does My Traffic Flow?**

**Setup:**
1. **Deploy Simple Apps:**  
   - Start two instances of a basic app (Python Flask, Node.js, or simply `python -m http.server`) on two different VMs/containers or on different ports.
2. **Configure NGINX as Load Balancer/Reverse Proxy:**  
   - On a third VM/host, install NGINX and configure it to proxy traffic to the two app backends.

**Sample `nginx.conf` for reverse proxy:**
```nginx
http {
    upstream myapp {
        server 192.168.10.10:8000;
        server 192.168.20.20:8000;
    }
    server {
        listen 80;
        location / {
            proxy_pass http://myapp;
        }
    }
}
```
3. **Test Access:**  
   - Use `curl` or a browser to access the app via NGINX (`http://<nginx-ip>`).

**Experiment:**
4. **Simulate Failure:**  
   - Stop one backend app (`kill` the process or `docker stop`) and access via NGINX again.
5. **Debug Traffic Flow:**  
   - Use `ip route`, `ss -tuln`, `ping`, `traceroute`, and review NGINX logs.
   - What does NGINX do when a backend is down? Does the traffic route to the healthy instance?

**Questions:**
- How does NGINX know where to send traffic?
- What changes at Layer 3 when a backend is down?
- How do you localise the failure using network commands?
- How does this all appear in your troubleshooting outputs?

**Submission:**
- Include:
    - Your NGINX config
    - Outputs from `ip route`, `ss -tuln`, and relevant logs
    - A short analysis of what you observed and how Layer 3 knowledge helped you debug

---

## **Real-World Scenarios & Debugging**

### **Scenario 1: The Cloud VPC Mystery**
**Problem:** A VM in `subnet-private` can't pull updates from the internet, but a VM in `subnet-public` can.

**Investigation:**
1. **Check Route Tables:** Is the default route in `subnet-private`’s table pointing to a **NAT Gateway**?
2. **Check NACLs/Security Groups:** Is outbound traffic (80/443, 1024-65535) allowed?
3. **Check if the subnet has a route to an Internet Gateway or NAT?**

### **Scenario 2: The Hybrid Cloud Tunnel**
**Problem:** On-prem app (`10.10.10.5`) cannot reach cloud DB (`10.20.30.5`) after maintenance.

**Investigation:**
1. **Traceroute:** Where does it stop?
2. **VPN/Direct Connect:** Is BGP up, routes advertised?
3. **Firewalls:** Are ACLs allowing the right traffic?

---

## **Mini Incident Simulation**

**Alert:** Web servers in availability zone 1a fail health checks from the load balancer in 1b.

You check a web server:
```bash
$ ip addr show eth0
inet 10.0.1.25/20 brd 10.0.15.255 scope global eth0

$ ip route show
10.0.0.0/20 dev eth0 proto kernel scope link src 10.0.1.25
default via 10.0.0.1 dev eth0
```
The load balancer's IP is `10.0.16.105`.

**Tasks:**
1. Calculate the subnet range for `10.0.0.0/20`. Is the LB in the same subnet?
2. Where will the web server send packets destined for the LB?
3. Can packets reach it directly? Why or why not?
4. Propose a fix so all resources are routable without a router.

---

##  **Advanced Gotchas for SREs**

- **MTU & Fragmentation:** VPNs or overlays with smaller MTU can fragment packets, hurting performance. Enable MTU Path Discovery or set MTU manually.
- **Asymmetric Routing:** Requests go through firewall A, responses out firewall B—B may drop them. Beware in multi-path topologies.
- **ECMP:** Multiple equal-cost paths can confuse stateful firewalls and impact packet order.
- **Network Namespaces:** Containers/pods have isolated stacks. A `ping` from the host may work, but not from inside a container due to separate routing tables. Debug with `nsenter` or `kubectl exec`.

---