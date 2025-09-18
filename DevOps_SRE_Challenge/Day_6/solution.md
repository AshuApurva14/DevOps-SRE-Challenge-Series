# DevOps SRE Challenge Day 7 Solution

 - #### So, till Day 7 challenge I have learned and gained lot of experience about DevOps SRE stuffs.Today I will be focsing on solving the theortical and Practical problems on GitHub Self-Hosted Runners.

- #### I will solve the theortical questions based on GitHub Self-Hosted Runners and it usecases.

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


4. **How to scale self-hosted runners?**

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


  <img width="3190" height="1812" alt="ec2_instance" src="https://github.com/user-attachments/assets/3bca3195-9de3-4a67-9604-e0bc4b00b131" />

  

#### **Step 2: Configure GitHub Self-Hosted Runner**

  1. Navigate to your **GitHub repository** → **Settings** → **Actions** → **Runners**.

  <img width="3200" height="1724" alt="Self-Hosted Runner" src="https://github.com/user-attachments/assets/48602ac5-8f90-435a-9354-5fbd1d94501b" />



  2. Click **"New self-hosted runner"**, select **Linux**, and follow the instructions to set it up. 

  <img width="3200" height="1730" alt="Day_7_3" src="https://github.com/user-attachments/assets/febd8ece-6eef-4812-bfc9-ce48fc646c1a" />



  3. SSH into the EC2 instance and install the runner using the provided commands.

    - For SSH, I will use Mobaxterm. You can use any SSH tool or even login directly from console using *EC2 Instance Connect*.

    <img width="3200" height="1680" alt="SSH login" src="https://github.com/user-attachments/assets/8ec0b689-9f9f-42ac-adb6-b76936f8acb3" />

    - After login, I refered the instructions below and executed the below comamnds for runner setup:

  **Download**
  
  <img width="3200" height="1752" alt="runner config" src="https://github.com/user-attachments/assets/ed5fc4fd-70f9-4f53-b77c-090f54dda1b9" />

```bash
  # Create a folder
    mkdir actions-runner && cd actions-runnerCopied
    
  # Download the latest runner package

    curl -o actions-runner-linux-x64-2.328.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.328.0/actions-runner-linux-x64-2.328.0.tar.gz

  # Optional: Validate the hash
    echo "Hash value" | shasum -a 256 -c
    
  # Extract the installer
    tar xzf ./actions-runner-linux-x64-2.328.0.tar.gz

```

  **Configure**

```bash
  # Create the runner and start the configuration experience
  ./config.sh --url <GitHub URL> --token <token>

```

 <img width="2764" height="1352" alt="ec2_instance-execution" src="https://github.com/user-attachments/assets/04e0db39-3751-4f37-8cd8-069a44f5376e" />

  4. Started the runner:

   ```bash
   ./run.sh

   ```
 
  <img width="2768" height="1672" alt="start_runner" src="https://github.com/user-attachments/assets/ad2cc4b3-4541-4182-b043-53e3881254a8" />

---

#### **Step 3: Deploy the Snake Game**

**For deployment of Snake Game in GitHub Runner, following prequisites needs to be fulfilled:

1. Install **Docker** on your EC2 instance:
```bash
   sudo apt update
   sudo apt install docker.io -y
```

  <img width="2768" height="770" alt="docker" src="https://github.com/user-attachments/assets/44149866-ceb3-4add-b36f-a0a6fff998ed" />

2.For deployment of Snake Game in GitHub Runner, I created GitHub actions workflows file name *cicd.yaml* file under path *.github/workflows* in the Snake Game Repo.

[cicd.yaml](https://github.com/AshuApurva14/season2-snake_game/blob/main/.github/workflows/cicd.yaml)

*This CICD workflow has following steps:*



  - Lint using ruff
  - Secret_scanning using gitleaks
  - Code_analysis using SonarQube
  - Automated testing using pytest
  - Docker imagde build using docker
  - Image Vulnerability Scanning using Aqua Trivy
  - Push docker ige to DockerHub
  - Set image tag for deployment
  - Deploy the application in GitHub RUnner
  - Check and verify the application Health
  - Send and Email notifictaion for deployment status
  

  <img width="3168" height="1502" alt="cicd" src="https://github.com/user-attachments/assets/c19e9c5d-840f-44b4-95d4-5ba51c181cab" />




 


  ### Issue

  docker permission issue

  sonarqube analysis issue



  