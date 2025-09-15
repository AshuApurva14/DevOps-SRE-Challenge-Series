## It's a Day 7  DevOps/SRE Challenge

 - **So, till Day 7 challenge I have learned and gained lot of experience about DevOps SRE stuffs.Today I will be focsing on solving the theortical and Practical problems on GitHub Self-Hosted Runners.**

- **I will solve the theortical questions based on GitHub Self-Hosted Runners and it usecases.**

---

### **Theortical Challenges**
---

1. **What is a GitHub runner?**

  *A GitHub runner is a service that runs GitHub Actions workflows.*
  
  **Key points:**

   - Executes CI/CD pipeline jobs
   - Can be hosted by GitHub or self-hosted
   - Runs one job at a time
   - Reports progress and logs back to GitHub
   - Supports various operating systems (Linux, Windows, macOS)

2. **How do self-hosted runners differ from GitHub-hosted runners?**

   | Feature | GitHub-hosted | Self-hosted |
   |---------|--------------|-------------|
   | Management | Managed by GitHub | Managed by you |
   | Hardware | Predefined specs | Custom hardware |
   | Cost | Uses GitHub minutes | Uses your infrastructure |
   | Maintenance | Automatic updates | Manual updates required |
   | Software | Standard toolsets | Custom software possible |
   | Security | Auto-wiped after use | Manual security measures |


3. **Security considerations for self-hosted runners:**

   - **Access Control**
     ```bash
     # Example: Restrict runner to specific IP ranges

     sudo ufw allow from 192.168.1.0/24 to any port 22
     ```

   - **Network Security**
     - Use VPN or private networking
     - Implement proper firewall rules
     - Monitor network traffic

   - **Environment Isolation**
     ```yaml
     # Example: Using Docker for job isolation

     jobs:
       build:
         runs-on: self-hosted
         container: ubuntu:20.04
     ```

   - **Secret Management**

     - Use GitHub Secrets
     - Implement vault solutions
     - Regular secret rotation


4. **How to scale self-hosted runners:**

   - **Horizontal Scaling**
     ```bash
     # Example: Auto-scaling script

     ./config.sh --url https://github.com/org/repo --token ${TOKEN}
     ```

   - **Load Distribution**
     ```yaml
     # GitHub Actions workflow example

     jobs:
       build:
         runs-on: 
           group: production-runners
           labels: ubuntu-latest
     ```

   - **Auto-scaling Solutions**

     - AWS Auto Scaling Groups
     - Kubernetes-based runners
     - Docker machine runners


5. **Can a single self-hosted runner be used for multiple repositories?**

   Yes, self-hosted runners can be shared across repositories with proper configuration:

   - **Organization Level Setup**
     ```yaml
     # Organization runner configuration

     actions:
       runners:
         groups:
           - name: shared-runners
             repositories:
               - repo1
               - repo2
     ```

   **Considerations:**

   - Security boundaries between repositories
   - Resource allocation and queuing
   - Maintenance scheduling
   - Access control management


---

### **⚙️ Practical Challenge: Setting Up a Self-Hosted Runner**

#### **Step 1: Create an EC2 Instance**

  1. Go to **AWS Console Page** > Search or Select **EC2** service > Select **Launch instance** option > **Name** the instance > Selcet **AMI** types as mentioned in the doc > add **key pair** 

  2. Add **Security group** rules and allow inbound traffic on ports **22 (SSH)** and **80 (HTTP)**.


 <img width="3189" height="1762" alt="EC2_instance" src="https://github.com/user-attachments/assets/93d86383-0fe8-4bd7-baac-47cc3b4249e5" />

  

  
 

  