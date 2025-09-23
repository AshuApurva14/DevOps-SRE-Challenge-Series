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


   <img width="3200" height="1402" alt="Image" src="https://github.com/user-attachments/assets/3d861df3-0221-45d5-8a9d-6d34864e2220" />

  
### SSH via PuTTY (Windows)

For SSH into VM , I have used Putty since I am a Windows user. Below are the step for SSH into EC2 instance.

**Step-by-step:**

1. **Installed [PuTTY and PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)**  
   Download and install both tools on your Windows machine.


2. **Converted `.pem` to `.ppk` using PuTTYgen**  
   - Open **PuTTYgen**
   - Click **"Load"** and select your `k8s-key.pem` file  
   - Click **"Save private key"**  
   - Save it as `mykey.ppk` (you can skip the passphrase if not required)


     <img width="1200" height="912" alt="puttygen" src="https://github.com/user-attachments/assets/fc69a979-4955-4477-a75b-f3cadb853b3f" />

3. **Open PuTTY and configure connection**  

   Open putty and add details for hostname and username under session category:
  
      <img width="904" height="858" alt="putty" src="https://github.com/user-attachments/assets/a1f75f09-1720-41d3-a8b1-d47df3b55c72" />

   All three different linux distro have different login username mentioned below:

     ```
     ubuntu@<public-ip>       # For Ubuntu  
     ec2-user@<public-ip>     # For Amazon Linux / RHEL

     ```
   - Add the **Port:** `22`  

   - In the left panel, go to:  
     `Connection` → `SSH` → `Auth`  
     - Click **Browse**, and attach your `mykey.ppk` file

4. **Connect**
   - Click **"Open"**
   - Accept any security alert
   - You should now be logged into your EC2 instance 🎉

    <img width="904" height="850" alt="Putty" src="https://github.com/user-attachments/assets/16544b97-fc40-4b6d-a544-352a22ecccaa" />


**You are now connected to your VM via PuTTY!**

 
6. After login into VM run thie below command on ecah of the distro to check the Operating system related information:  
   ```bash
   cat /etc/os-release

 - For **Ubuntu 22.04 LTS**, I have executed above command got below details for Ubuntu OS :

   - **After Login**

     <img width="3194" height="1888" alt="Ubuntu_putty" src="https://github.com/user-attachments/assets/13a734ce-4575-4b69-80f0-8a9de61ee5f7" />

   - Executed **/etc/os-release** command:

     <img width="3200" height="1150" alt="os-releae_ubuntu" src="https://github.com/user-attachments/assets/0b3a98e7-4f51-4857-a93f-08a9cc04ea39" />

   - Execuetd **uname -r** to check kernel version:

     <img width="3200" height="954" alt="uname-r " src="https://github.com/user-attachments/assets/21fd1c03-a658-4d19-8267-805ebdb5e6a0" />


   - **Bonus Task**

    For ubuntu OS , I have installed htop(Human readable format verison of TOP ) a process management utlity for better visiblity of processes running on system

     <img width="3200" height="984" alt="Image" src="https://github.com/user-attachments/assets/a2e4f36d-545e-46a0-8809-d663b1c5da1e" />

   - **Below screenshot is showing all the running processes in human reddable format**

     <img width="3200" height="1906" alt="Image" src="https://github.com/user-attachments/assets/6694f15b-5fdf-4ed0-80a7-9d05eb3ae614" />

---


   - For **Amazon Linux 2**, I have executed above command got below details for Amaazon Linux OS :

   - **After Login**
   - Executed **/etc/os-release** command:

     <img width="3200" height="1216" alt="Iamazon" src="https://github.com/user-attachments/assets/bbf370a2-3f8f-4b06-b01b-a54238fec2db" />

   - Execuetd **uname -r** to check kernel version:

   <img width="3200" height="604" alt="Image" src="https://github.com/user-attachments/assets/83e267ac-1999-4c47-91aa-777ca6cb29a6" /> 



---


  - For **RHEL 9**, I have executed above command got below details for RHEL9  OS :

   - **After Login**
   - Executed **/etc/os-release** command:

      <img width="3200" height="1488" alt="Image" src="https://github.com/user-attachments/assets/dd48c2d2-1873-4fd9-b6b0-ae812877c922" />

   - Execuetd **uname -r** to check kernel version:

      <img width="3200" height="686" alt="Image" src="https://github.com/user-attachments/assets/292ed18b-5f70-4ed6-9149-feadbe454a16" />

---

**Troubleshooting Tip:** SSH failing? Double-check your security group and key permissions (`chmod 400 ssh.pem`).

---

### **Step 2: Install RHEL on VirtualBox Locally**  
**Goal:** Set up a local RHEL VM to grasp virtualization hands-on.  

**Downloads:**  
- VirtualBox: [virtualbox.org](https://www.virtualbox.org)  
- RHEL ISO: [redhat.com](https://developers.redhat.com/products/rhel/download) (free developer account).  

1. Open VirtualBox and add all required deatils such as:

    - Name: "RHEL9" 
    - Type: Linux  #Automatically added
    - Version: Red Hat (64-bit).   #Automatically added
    - ISO image
    - Username and Password
    - Virtual Hardware specification (Allocate:   RAM: 2 GB+ , Disk: 20 GB+ (dynamic))
    - Virtual hard disk specification


   <img width="1608" height="1114" alt="Image" src="https://github.com/user-attachments/assets/115baa28-cada-494d-afd4-45c1576e819c" />

4. Start the VM and follow the installer (default settings are fine).  

5. Post-install, log in and run:  
   ```bash
   sudo dnf update -y
   cat /etc/os-release


<img width="3190" height="1914" alt="Image" src="https://github.com/user-attachments/assets/6b59fa48-5aa0-4bed-8b81-5db2f4c94cbd" />


<img width="3200" height="1900" alt="Image" src="https://github.com/user-attachments/assets/5f808971-6559-41f4-8e99-38b9b4b61391" />


## **Challenged Faced**

  - **VirtualBox** RHEL9 VM installation errors

    - I have reinstalled the iso image version and reconfigured it by ensuring every details and prequisite must be met.


## **Key Takeaways**

  - Ensure all settings and key configurations must be set properly for successfull execution of setup.