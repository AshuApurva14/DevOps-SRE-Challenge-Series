## OSI Model
```mermaid
flowchart TD
   L7[Application Layer] 
   L6[Presentation Layer]
   L5[Session Layer]
   L4[Transport Layer]
   L3[Network Layer]
   L2[DataLink Layer]
   L1[Physical Layer]



   L7 --> L6 --> L5 --> L4 --> L3 --> L2 --> L1

   L7PT[Protocols: HTTP, SSH
       Tools: curl, ssh]
   L6PT[Protocols: TLS/SSL, ASCII
       Tools: openssl]
   L5PT[Protocols: RPC, NetBIOS]
   L4PT[Protocols: TCP, UDP
       Tools: nc, ss]
   L3PT[Protocols: IP, ICMP
       Tools: ping, traceroute]
   L2PT[Protocols: Ethernet, ARP
       Tools: ip link, arp]
   L1PT[Protocols: wifi, cables
       Tools: ethpool, ip link]

   L7 --> L7PT
   L6 --> L6PT
   L5 --> L5PT
   L4 --> L4PT
   L3 --> L3PT
   L2 --> L2PT
   L1 --> L1PT


```
## TCP/IP Model
```mermaid
flowchart TD
L4[Application Layer]
L3[Transport Layer]
L2[Internet Layer]
L1[Network Layer]

L4 --> L3 --> L2 --> L1

L4PT[Protocols: HTTP,SSH.SMTP, DNS
     Tools: curl]
L3PT[Protocols: TCP, UDP
     Tools: ss]
L2PT[Protocols: IP, ICMP
     Tools: ping, traceroute]
L1PT[Protocols: ETHERNET, ARP
     Tools: ip link, ethtool]

L4 --> L4PT 
L3 --> L3PT
L2 --> L2PT
L1 --> L1PT

```