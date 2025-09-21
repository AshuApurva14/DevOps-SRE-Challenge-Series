## Day 8: Kickstart Your Journey with Linux & Virtualization

## 5️⃣ Challenge Breakdown  

### **📝 Theoretical Questions**  
Answer these to solidify your understanding:  
1. What is Unix, and how does it relate to Linux?  
  
   - **Unix is a proprietary Operating System which is Highly stable, efficient, multi-user, and multitasking.**

   - **It is Developed in the 1960s and 1970s at AT&T's Bell Labs.** 

   - **The relationship between Unix and Linux is that Linux is a free, open-source operating system modeled on Unix but without using its proprietary source code.**
   - **Unix provided the core design and philosophy, and Linux was created as a functionally similar, alternative implementation.**




2. How does Linux’s open-source nature benefit DevOps workflows?  

   **Following are the Linux Open source nature which benefits DevOps Workflows:**

    - **Flexibility and Customization**

      1. **Tailored Environments:**** Developers can access and modify the source code, enabling them to customize the operating system and related tools to meet their specific needs and workflows. 
      2. **Adaptability:** This adaptability is crucial for DevOps, which requires tools and processes that can evolve and integrate with new technologies and changing requirements. 



    - **Cost Optimizaton**

      1. **No Licensing Fees:** The open-source nature of Linux eliminates costly licensing fees, allowing teams to invest more in development and infrastructure rather than software costs. 
      2. **Wider Adoption:** It makes powerful development tools and environments accessible to everyone, from individual developers to large enterprises, promoting broader adoption and standardization. 


    - **Community Support and Innovation**
      
      1. **Rapid Development:** A vibrant global community contributes to the rapid development of new tools, plugins, and extensions that enhance the Linux ecosystem. 
      2. **Collaboration:** The open-source model promotes a culture of collaboration and knowledge sharing, which aligns perfectly with the DevOps philosophy of transparency and shared responsibility. 
      

    - **Stability, Reliability and Security**

      1. **Robustness** - Linux is known for its Stability and Reliability which are critical for Continous Delivery and operations of application.
      2. **Security** - The open-source nature allows for rapid identification and patching of vulnerabilities by the community, leading to more secure systems. 


    - **Foundation for DevOps Tools**

      1. **Tool ecosystem** - Many DevOps tools such as Jenkins, Ansible , Terraform are open source and designed to run on linux.
      2. **Containerization** - Linux's architecture is ideal for containerization tool.e.g- Docker, Kubernetes.



3. What’s the role of the Linux kernel in virtualization?  

    - The Linux kernel enables virtualization by integrating technologies like KVM (Kernel-based Virtual Machine) to act as a hypervisor.

    -  Allowing it to run multiple isolated virtual machines (VMs) on a single physical machine by managing hardware resources such as CPU, memory, and storage.

    - The kernel also provides essential components like control groups (cgroups) and namespaces for creating lightweight containers (like LXC and Docker) that share the host's kernel but have their own isolated environments.


4. What’s the difference between Type 1 and Type 2 hypervisors?  

   The main difference between **Type 1(bare metal)** and **Type 2(Hosted)** Hypervisor are:

   - **Type 1(Bare metal)** such as KVM run directly on hardware, managing guest OSes without a host operating system.

   - **Type 2(Hosted)** like VirtualBox or VMware Workstation, run as an application on the host Linux OS, making them suitable for desktop and development environments.



5. Why might an SRE prefer Linux for monitoring production systems? 

    **Key Reasons why SRE prefer Linux for Monitoring production systems:**

  - **Open-Source & Customization:** Linux is open-source, allowing extensive customization to fit specific monitoring needs. Its flexible nature enables users to optimize systems for their particular workflows and environments. 

  - **Stability & Reliability:** Linux is known for its stability and reliability, seldom slowing down or requiring reboots, which is crucial for 24/7 production environments. 

  - **Security:** Its secure design and open-source model allow for frequent code reviews, quickly identifying and patching vulnerabilities, making it a more secure platform. 

  - **Performance & Resource Efficiency:** Linux is a lean and fast operating system that efficiently utilizes system resources, allowing it to handle large amounts of data and traffic with excellent performance.

  - **Monitoring Tools & Automation:** A wide range of monitoring tools, from lightweight CLIs to advanced IDEs, are available on Linux, and its inherent design supports automation, making monitoring and management more efficient. 

  - **Community Support:** The strong, active global community provides robust support, frequent updates, and a constant stream of new tools and solutions.

  - **Cost-Effectiveness:** As a free, open-source operating system, Linux offers significant cost savings compared to proprietary alternatives. 

  - **DevOps & Cloud Integration:** Linux is a cornerstone of modern cloud computing and DevOps, providing excellent compatibility and support for virtualization, containerization, and configuration management. 

---


### **⚙️ Practical Challenge: Mastering Linux & Virtualization**  

#### **Step 1: Launch EC2 Instances with Linux Distros**  
**Goal:** Deploy three Linux distros on AWS EC2 to explore their differences.  
1. Log into AWS → EC2 → "Launch Instance."  

2. Select the AMIs (use `t2.micro` for free tier) to launch the below mentioned distro based EC2 instance:  
   - **Ubuntu 22.04 LTS**: Search "Ubuntu 22.04" in AMI catalog.  

       <img width="1816" height="1188" alt="UbuntuAMI" src="https://github.com/user-attachments/assets/1002e35d-7735-4d00-937e-35a79a827654" />

      <img width="3186" height="1730" alt="Ubuntu_ec2" src="https://github.com/user-attachments/assets/c4e8ffe9-eacb-4b79-9678-8673b81db112" />


    - **Amazon Linux 2**: Default EC2 option.  

      <img width="1768" height="1114" alt="AMI-Amazon" src="https://github.com/user-attachments/assets/0844e098-fa9d-4d91-bbbf-c246946c435d" />

      <img width="3221" height="1684" alt="amazon" src="https://github.com/user-attachments/assets/5d11287e-993f-455f-9f23-b9ac05f0dfe0" />


    - **RHEL 9**: Search "Red Hat Enterprise Linux 9."  


      <img width="1799" height="1136" alt="Rhel_AMI" src="https://github.com/user-attachments/assets/311a4615-07f7-45d9-9355-db3a8528cbba" />

      <img width="3210" height="1640" alt="rhel" src="https://github.com/user-attachments/assets/8be96b7f-8c2a-4d54-93e0-eddd0e85a054" />
    

3. Set up a key pair (e.g., `mykey.pem`).  

4. Configure security group: Allow port 22 (SSH) from your IP. 

    - **Ubuntu 22.04 LTS**: 

      <img width="3200" height="1549" alt="ubuntu_ec2" src="https://github.com/user-attachments/assets/1f72ebb5-a254-484e-982f-5d76b7530408" />

    
    - **Amazon Linux 2**: Default EC2 option.  


      <img width="3200" height="1414" alt="Amazon_sg" src="https://github.com/user-attachments/assets/193bd1f9-014e-4f98-aae9-52d77fb1a0be" />


     - **RHEL 9**: Search "Red Hat Enterprise Linux 9."  

       
       <img width="3235" height="1300" alt="rhelsg" src="https://github.com/user-attachments/assets/9887772f-7a59-4797-8679-6ac84b8efa6b" />


    
5. Now you have the new  different Linux based distro EC2 instance running in your dashboard.

5. For SSH into VM , I have used Putty since I am a Windows user. Below are the step for SSH into EC2 instance.
  
### Connect via PuTTY (Windows)

**Step-by-step:**

1. **Install [PuTTY and PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)**  
   Download and install both tools on your Windows machine.

2. **Convert `.pem` to `.ppk` using PuTTYgen**  
   - Open **PuTTYgen**
   - Click **"Load"** and select your `mykey.pem` file  
   - Click **"Save private key"**  
   - Save it as `mykey.ppk` (you can skip the passphrase if not required)

3. **Open PuTTY and configure connection**  
   - In **Host Name**, enter:  
     ```
     ubuntu@<public-ip>       # For Ubuntu  
     ec2-user@<public-ip>     # For Amazon Linux / RHEL
     ```
   - **Port:** `22`  
   - In the left panel, go to:  
     `Connection` → `SSH` → `Auth`  
     - Click **Browse**, and attach your `mykey.ppk` file

4. **Connect**
   - Click **"Open"**
   - Accept any security alert
   - You should now be logged into your EC2 instance 🎉

**You are now connected to your VM via PuTTY!**


6. Run this on each:  
   ```bash
   cat /etc/os-release

---

### Repeat the Same on Azure & GCP

---

#### **Azure – Launch a Linux VM**

1. Go to **[Azure Portal](https://portal.azure.com)** → `Virtual Machines` → **Create VM**
2. Choose your desired Linux distribution:
   - Ubuntu  
   - RHEL  
   - CentOS
3. For free-tier eligible setup:
   - **Size:** `Standard_B1s`
4. **Authentication type:**  
   - Select **SSH public key**
   - Upload or generate a new key pair
5. Under **Networking**, open **Port 22 (SSH)**
6. Click **Review + Create**, then **Create**

**Connect Options:**  
- Use Azure Cloud Shell's SSH option  
- Or use **PuTTY / terminal** with your `.pem` or converted `.ppk` key (same as AWS SSH steps)

---

#### **GCP – Launch a Linux VM (Compute Engine)**

1. Go to **[GCP Console](https://console.cloud.google.com)** → `Compute Engine` → `VM Instances` → **Create Instance**
2. Select your preferred OS:
   - Ubuntu  
   - RHEL  
   - Debian
3. Choose machine type:
   - **e2-micro** (Free tier eligible)
4. Scroll to **Security** section:
   - Add your **SSH public key**
5. Under **Firewall**, check:
   - ✅ Allow HTTP traffic  
   - ✅ Allow SSH traffic
6. Click **Create**

**Connect Options:**  
- Use GCP’s built-in browser-based SSH  
- Or use **external SSH client / PuTTY**:
   ```bash
   ssh -i your-key.pem username@<external-ip>


**Troubleshooting Tip:** SSH failing? Double-check your security group and key permissions (`chmod 400 mykey.pem`).

---

### **Step 2: Install RHEL on VirtualBox Locally**  
**Goal:** Set up a local RHEL VM to grasp virtualization hands-on.  

**Downloads:**  
- VirtualBox: [virtualbox.org](https://www.virtualbox.org)  
- RHEL ISO: [redhat.com](https://developers.redhat.com/products/rhel/download) (free developer account).  

1. Open VirtualBox → "New" → Name: "RHEL9" → Type: Linux → Version: Red Hat (64-bit).  
2. Allocate:  
   - RAM: 2 GB+  
   - Disk: 20 GB+ (dynamic)  
3. Mount the RHEL ISO in Settings → Storage.  
4. Start the VM and follow the installer (default settings are fine).  
5. Post-install, log in and run:  
   ```bash
   sudo dnf update -y
   cat /etc/os-release