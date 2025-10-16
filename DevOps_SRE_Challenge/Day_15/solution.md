# Daily DevOps + SRE Challenge Series – Season 2  
## Day 15: OSI & TCP/IP Model Foundations for DevOps/SRE

### Solution

Day 15 of DevOps/SRE Challenge Season 2
---

###  Hands-On Challenge 

#### Scenario A: Draw diagram of OSI and TCP models and Map 

- Draw both models (on paper or using a tool)



- List at least 2 protocols and 2 tools for each layer (see tables above)
- Save a photo/image/markdown table in your solution

#### Scenario B: Protocol Mapping Exercise

Given these tools/protocols, map each to its layer(s):  
- ping  
- ssh  
- dig  
- curl  
- nc  
- ip addr  
- arp  
- openssl  
- traceroute  
- tcpdump  

Fill out a table like:
| Tool/Protocol | OSI Layer(s) | TCP/IP Layer | Description |
|---------------|--------------|--------------|-------------|
| ping          | 3, 1         | Internet     | Tests IP reachability using ICMP |
| ssh           | 7, 4         | Application, Transport | Secure shell (needs network and transport) |
| ...           | ...          | ...          | ...         |

#### Scenario C: Mini Incident Simulation

A developer says:  
> “I can’t reach the app at http://10.10.10.20:5000 from my laptop. Ping fails, but DNS resolves.”

Your task:
1. Identify which layer(s) might be failing based on symptoms
2. List which commands/tools you would use in order to troubleshoot—from bottom to top

Document your answer in solution.md.

---

### 4) What to Watch For (Common Gotchas)
- Not every protocol is at only one layer (e.g., DNS = Application, but depends on Transport/Network)
- Some tools work at multiple layers (e.g., tcpdump sees almost everything!)
- Real-world cloud infra may “hide” some layers (e.g., you don’t see cables, but you still check link status in VMs)
- The PDU (data format) matters for troubleshooting (e.g., "packet loss" is different from "frame error")

---
