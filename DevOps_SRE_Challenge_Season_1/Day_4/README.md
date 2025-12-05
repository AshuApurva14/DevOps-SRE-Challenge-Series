# Day4 Challenge: Design, Deploy, and Diagnose: A Comprehensive Cloud Project with Flask and MySQL

## Solution


  ### From Local to Cloud and From Design to Failure Recovery: Deploying Flask Apps with MySQL on AWS
  
This project implements a production‑style two‑tier architecture on AWS:

- Flask application in a **public subnet**
- MySQL database in a **private subnet**
- Communication over **private IP**
- **Nginx + SSL** terminating HTTPS in front of Flask
- **Failure simulation & troubleshooting** for the DB layer

---

## 1. High‑Level Architecture

- **VPC**: e.g. `10.0.0.0/16`
- **Public subnet** (Flask): e.g. `10.0.1.0/24`
- **Private subnet** (MySQL): e.g. `10.0.2.0/24`
- **Internet Gateway** attached to VPC for public subnet
- **NAT Gateway** in public subnet for private subnet outbound internet
- **Flask EC2** in public subnet with public IP
- **MySQL EC2** in private subnet, no public IP
- Traffic:
  - Users → HTTPS → Nginx (public EC2) → Flask (localhost:5000)
  - Flask → MySQL via **private IP** on port 3306

---

## 2. VPC & Networking Setup

### 2.1 Create VPC and Subnets

1. Create a VPC:
   - CIDR: `10.0.0.0/16`
2. Create subnets:
   - Public subnet: `10.0.1.0/24` (auto‑assign public IP enabled)
   - Private subnet: `10.0.2.0/24` (no public IPs)

### 2.2 Internet Gateway and NAT

1. Create and attach an **Internet Gateway** to the VPC.
2. Create a **NAT Gateway**:
   - In the public subnet
   - With an Elastic IP

### 2.3 Route Tables

- **Public route table** (associate with public subnet):
  - `10.0.0.0/16 → local`
  - `0.0.0.0/0 → igw-xxxx`
- **Private route table** (associate with private subnet):
  - `10.0.0.0/16 → local`
  - `0.0.0.0/0 → nat-xxxx`

---

## 3. Security Groups

### 3.1 Flask EC2 Security Group (e.g. `flask-sg`)

**Inbound:**

- SSH: port 22, source = your IP (`X.X.X.X/32`)
- HTTP: port 80, source = `0.0.0.0/0`
- HTTPS: port 443, source = `0.0.0.0/0`

**Outbound:**

- Allow all (default), or ensure:
  - TCP 3306 to MySQL SG
  - 80/443 to internet for updates

### 3.2 MySQL EC2 Security Group (e.g. `mysql-sg`)

**Inbound:**

- SSH: port 22, source = `flask-sg`
- MySQL: port 3306, source = `flask-sg`
- ICMP: All, source = `flask-sg` (for ping while troubleshooting)

**Outbound:**

- Allow all (default).

---

## 4. MySQL EC2 – Manual Installation & Configuration

### 4.1 Launch MySQL EC2

- AMI: Ubuntu 22.04 LTS
- Subnet: **private subnet**
- Security Group: `mysql-sg`
- No public IP.

### 4.2 SSH via Flask EC2 (Jump Host)

On your local machine:

ssh -i flask-key.pem ubuntu@<FLASK_PUBLIC_IP>

From Flask to MySQL:

ssh -i mysql-key.pem ubuntu@<MYSQL_PRIVATE_IP>

(Or configure ProxyJump/SSH config to simplify.)

### 4.3 Install MySQL Server

On MySQL instance:

sudo apt update
sudo apt install mysql-server -y
sudo systemctl enable mysql
sudo systemctl start mysql
sudo systemctl status mysql


### 4.4 Secure MySQL

sudo mysql_secure_installation

- Set strong root password
- Remove anonymous users
- Disallow remote root login
- Remove test database
- Reload privileges



### 4.5 Configure MySQL Networking

Edit config:

sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf


In `[mysqld]` section:

```bash
bind-address = 0.0.0.0
skip-name-resolve
```


Restart and verify:

sudo systemctl restart mysql
sudo ss -tlnp | grep 3306

Expect: 0.0.0.0:3306 or <MYSQL_PRIVATE_IP>:3306


### 4.6 Create Database and User

sudo mysql

```bash
CREATE DATABASE flask_app_db;

CREATE USER 'flask_user'@'%' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON flask_app_db.* TO 'flask_user'@'%';
FLUSH PRIVILEGES;

USE flask_app_db;
CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email)
VALUES ('admin', 'admin@example.com'), ('test', 'test@example.com');

EXIT;

```


---

## 5. Flask EC2 – Application Setup

### 5.1 Launch Flask EC2

- AMI: Ubuntu 22.04 LTS
- Subnet: **public subnet**
- Assign public IP
- Security group: `flask-sg`

### 5.2 Install Python, Tools, and Nginx



ssh -i flask-key.pem ubuntu@<FLASK_PUBLIC_IP>

sudo apt update
sudo apt install -y python3 python3-pip python3-venv mysql-client nginx


### 5.3 Create Project & Virtualenv



```bash
mkdir -p ~/flask-app
cd ~/flask-app

python3 -m venv venv
source venv/bin/activate
```


### 5.5 Flask Application (`app.py`)

```bash

pip install flask pymysql python-dotenv gunicorn
pip freeze > requirements.txt


import mysql.connector
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    try:
        conn = mysql.connector.connect(
            host="172.31.81.39",
            user="flask_user",
            password="FlaskPassword123!",
            database="flask_app_db"
        )
        return "Connected to the database!"
    except mysql.connector.Error as err:
        return f"Error connecting to database: {err}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

```



### 5.6 Test DB Connectivity from Flask EC2


mysql -h <MYSQL_PRIVATE_IP> -u flask_user -p



---

## 6. Nginx + SSL (HTTPS & Redirect)

### 6.1 Self‑Signed Certificate

```bash
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048
-keyout /etc/nginx/ssl/flask-app.key
-out /etc/nginx/ssl/flask-app.crt

sudo chmod 600 /etc/nginx/ssl/flask-app.key
sudo chmod 644 /etc/nginx/ssl/flask-app.crt
```



### 6.2 Nginx Site Config


```bash
# HTTP Server - Redirect all traffic to HTTPS
server {
    listen 80;
    server_name <FLASK_PUBLIC_IP>;  # Replace with your IP or domain

    # Redirect all HTTP requests to HTTPS
    return 301 https://$host$request_uri;
}

# HTTPS Server
server {
    listen 443 ssl http2;
    server_name <FLASK_PUBLIC_IP>;  # Replace with your IP or domain

    # SSL Certificate Configuration
    ssl_certificate /etc/nginx/ssl/flask-app.crt;
    ssl_certificate_key /etc/nginx/ssl/flask-app.key;

    # SSL Security Settings
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    # Logging
    access_log /var/log/nginx/flask-app-access.log;
    error_log /var/log/nginx/flask-app-error.log;

    # Proxy settings for Flask application
    location / {
        proxy_pass http://127.0.0.1:5000;  # Flask app on localhost:5000
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Timeout settings
        proxy_connect_timeout 60s;
        proxy_read_timeout 60s;
        proxy_send_timeout 60s;
    }

    # Health check endpoint
    location /health {
        proxy_pass http://127.0.0.1:5000/health;
        proxy_set_header Host $host;
    }
}

```


Enable and reload:

sudo ln -s /etc/nginx/sites-available/flask-app /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default || true

sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx


### 6.3 Run Flask Behind Nginx

cd ~/flask-app
source venv/bin/activate

python3 app.py


Access in browser:

- `http://<FLASK_PUBLIC_IP>` → redirected to `https://<FLASK_PUBLIC_IP>`
- `https://<FLASK_PUBLIC_IP>/health`
- `https://<FLASK_PUBLIC_IP>/users`

(Expect “connection not secure” warning due to self‑signed cert; acceptable for lab.)

---

## 7. Failure Simulation & Troubleshooting

### 7.1 Simulate MySQL Failure

On MySQL EC2:

```bash
sudo systemctl stop mysql
sudo systemctl status mysql
sudo ss -tlnp | grep 3306 # should be empty
```


### 7.2 Observe App Behaviour

From local or Flask EC2:


curl https://<FLASK_PUBLIC_IP>/health
curl https://<FLASK_PUBLIC_IP>/users


Expect DB connection errors

Check logs:

Flask / gunicorn logs
tail -f ~/flask-app/gunicorn.log

Nginx error logs
sudo tail -f /var/log/nginx/flask-app-error.log


### 7.3 Network & Port Checks

From Flask EC2:


ping -c 3 <MYSQL_PRIVATE_IP> # network/route check
nc -zv <MYSQL_PRIVATE_IP> 3306 # transport/port check


### 7.4 Root Cause & Recovery

Expected findings:

- Ping to `<MYSQL_PRIVATE_IP>`: **success**
- `nc -zv <MYSQL_PRIVATE_IP> 3306`: **fails** while MySQL is stopped
- `systemctl status mysql`: **inactive (dead)**

Recovery:


On MySQL EC2
sudo systemctl start mysql
sudo systemctl status mysql
sudo ss -tlnp | grep 3306

From Flask EC2
nc -zv <MYSQL_PRIVATE_IP> 3306
mysql -h <MYSQL_PRIVATE_IP> -u flask_user -p -e "SELECT 1;"
curl https://<FLASK_PUBLIC_IP>/health
curl https://<FLASK_PUBLIC_IP>/users

## Issues I Faced (and How I Resolved Them)


Ping between app and DB failed

Cause: ICMP not allowed in DB security group.

Fix: Added ICMP (All) from Flask SG → MySQL SG.

MySQL connection timeout / Error 2003 / Error 110

Cause: MySQL listening only on 127.0.0.1:3306 and/or SG missing port 3306.

Fix: Set bind-address = 0.0.0.0, restarted MySQL, added SG rule for port 3306 from Flask SG.

Host not allowed to connect (Error 1130)

Cause: MySQL user created with wrong user@host (didn’t match Flask EC2 IP).

Fix: Dropped wrong users, recreated flask_user as 'flask_user'@'%', granted privileges on flask_app_db, and FLUSH PRIVILEGES.

Security group edit error: “You may not specify a referenced group id for an existing IPv4 CIDR rule”

Cause: Tried to change an existing IP‑based rule into an SG reference.

Fix: Deleted the old CIDR rule, added a new rule referencing the Flask SG.

MySQL logs clean, but still unreachable from Flask

Cause: bind-address change not applied / duplicate configuration.

Fix: Ensured only one bind-address in mysqld.cnf, set to 0.0.0.0, restarted MySQL, verified with ss -tlnp | grep 3306.


## Key issues and Resolution


Always debug layer by layer
Start from network (ping), then transport (nc/telnet), then service (systemd), then app (logs), then auth/config. It saves a lot of time and guesswork.

Security groups are your first line of defense
Use SG→SG references, avoid 0.0.0.0/0 on sensitive ports, and keep MySQL in a private subnet with no public IP.

MySQL in VPCs needs special care

bind-address matters.

skip-name-resolve avoids reverse DNS headaches.

Always double‑check user@host when creating DB users.

Reverse proxy + SSL is the real-world pattern
Terminate TLS at Nginx, keep Flask bound to localhost, redirect HTTP → HTTPS, and centralize cross‑cutting concerns.

Failure simulation is the best teacher
Intentionally stopping MySQL and then working through the incident like an SRE (observability, hypothesis, verification, remediation, and post‑mortem) is far more valuable than just a “happy‑path” deployment.


