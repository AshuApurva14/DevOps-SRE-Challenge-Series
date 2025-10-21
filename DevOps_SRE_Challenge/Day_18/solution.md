## **Day 18: OSI Layer 4 – The Transport Layer (TCP, UDP, Ports, and Real-World Debugging)**

## Solution
---

##  **Hands-On Lab: Layer 4 in Action**

### **Lab 1: TCP/UDP Connections with Netcat**

**A. TCP Echo Test**
1. On one terminal, run a TCP server:
    ```bash
    nc -l 9000
    ```
2. On another terminal, connect as a client:
    ```bash
    nc 127.0.0.1 9000
    ```
3. Type messages – verify bidirectional communication.
4. Observe connection with:
    ```bash
    ss -tna | grep 9000
    ```

**B. UDP Echo Test**
1. On one terminal, run a UDP server:
    ```bash
    nc -lu 9001
    ```
2. On another terminal, send a UDP message:
    ```bash
    echo "hello" | nc -u 127.0.0.1 9001
    ```
3. UDP is stateless—observe the difference in `ss -una | grep 9001`.

---

### **Lab 2: TCP Handshake & State Machine with tcpdump**

1. In one terminal, start a simple TCP server (e.g., Python):
    ```bash
    python3 -m http.server 8080
    ```
2. In another, start packet capture:
    ```bash
    sudo tcpdump -i lo tcp port 8080 -w handshake.pcap
    ```
3. In a third, connect:
    ```bash
    curl http://localhost:8080
    ```
4. Stop tcpdump. Open `handshake.pcap` in Wireshark and analyze:
    - Find SYN, SYN-ACK, ACK packets (3-way handshake)
    - See FIN/ACK for teardown

5. List TCP connection states:
    ```bash
    ss -tan state all | grep 8080
    ```

---

##  **Mini Incident Simulation**

**Scenario:**  
Your web app is intermittently failing to connect to its database. The app logs show `Connection refused` and `Too many open files`.  
You run:

```bash
ss -s
ss -tan | grep 5432
ulimit -n
```
- You see hundreds of connections in `TIME_WAIT` to port 5432, and `ulimit -n` is 1024.

**Tasks:**
1. What is `TIME_WAIT` and why does it happen?
2. How can too many connections in `TIME_WAIT` cause failures?
3. What are two ways to mitigate this issue (at the OS/app level)?
4. What Layer 4 lesson does this teach for SREs?

---

##  **Common SRE Pitfalls & Gotchas**

- **Ephemeral Port Exhaustion:**  
  Too many outgoing connections can exhaust source ports. Tweak ephemeral range and app keepalive settings.
- **Firewall/Security Group Rules:**  
  Ensure correct protocol (TCP vs. UDP) and port are allowed—port 53/UDP ≠ port 53/TCP!
- **Stateless vs. Stateful Load Balancing:**  
  Sticky sessions can break if not handled at Layer 4.
- **NAT & Connection Tracking:**  
  NAT device may drop idle connections or run out of state table slots.
- **Socket Options:**  
  Tuning `tcp_tw_reuse`, `tcp_fin_timeout`, and `ulimit` can help, but can also cause subtle bugs.

---