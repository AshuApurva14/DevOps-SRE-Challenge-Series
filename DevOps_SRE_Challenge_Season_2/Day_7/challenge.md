## 3️⃣ Challenge Breakdown

### **📝 Theoretical Questions**
Answer the following questions:
1. What is a GitHub runner?
2. How do self-hosted runners differ from GitHub-hosted runners?
3. What security considerations should you take when using self-hosted runners?
4. How can you scale self-hosted runners?
5. Can a single self-hosted runner be used for multiple repositories? Why or why not?



### **⚙️ Practical Challenge: Setting Up a Self-Hosted Runner**

#### **Step 1: Create an EC2 Instance**
1. Launch an AWS EC2 instance (Ubuntu 22.04 recommended).
2. Allow inbound traffic on ports **22 (SSH)** and **80 (HTTP)**.

#### **Step 2: Configure GitHub Self-Hosted Runner**
1. Navigate to your **GitHub repository** → **Settings** → **Actions** → **Runners**.
2. Click **"New self-hosted runner"**, select **Linux**, and follow the instructions to set it up.
3. SSH into the EC2 instance and install the runner using the provided commands.
4. Start the runner:
   ```bash
   ./run.sh
   ```

#### **Step 3: Deploy the Snake Game**


https://github.com/user-attachments/assets/3c0e0fc7-a5ef-4285-9b3a-4cdb57915f0e


1. Install **Docker** on your EC2 instance:
   ```bash
   sudo apt update
   sudo apt install docker.io -y
   ```
2. Clone the **Snake Game repository**:
   ```bash
   git clone https://github.com/clear-code-projects/Snake
   cd Snake
   ```
3. Build and run the application as a Docker container:
   ```bash
   docker build -t snake-game .
   docker run -d -p 80:5000 snake-game
   ```
4. Confirm the deployment by accessing `http://<EC2-Public-IP>` in a browser.

5. You are required to create a GitHub Actions workflow that:
 **Builds and pushes a Docker image** to Docker Hub.
 **Deploys the application on Self Hosted GitHub Runners**
 **Validates that the application is running correctly**.
 **Sends an email notification** with the deployment status.

#### **Step 4: Take Screenshots for Submission**
- Running EC2 instance (`aws ec2 describe-instances`).
- GitHub Actions workflow logs showing execution on the self-hosted runner.
- Webpage running the Snake Game.


