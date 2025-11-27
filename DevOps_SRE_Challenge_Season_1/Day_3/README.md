# Grafana + Jenkins behind Nginx (HTTPS + Basic Auth)

-----------------------------------------------------------------------
## Solution - Day 3 Challenge: Multi-Service Reverse Proxy with Nginx
--------------------------------------------------------------------

## Overview

This guide shows how to run Grafana and Jenkins locally (via Docker), expose them through an Nginx reverse proxy on local domains (`grafana.local` and `jenkins.local`), secure the sites with HTTPS using a self-signed certificate, redirect HTTP to HTTPS, and protect access with Basic Authentication enforced at the proxy.

This setup is intended for development and learning only — do not use self-signed certificates or this exact configuration in production.

## Prerequisites

- Windows (PowerShell); commands below assume PowerShell execution.
- Docker & Docker Compose (or Docker Desktop).
- OpenSSL available in PowerShell, WSL, Git Bash, or installed separately.
- Administrator privileges to edit the hosts file.

## High-level Steps

- Add local host entries for `grafana.local` and `jenkins.local`.
- Generate a self-signed certificate with SAN entries for both domains.
- Create an `htpasswd` file for Basic Auth.
- Run Grafana and Jenkins containers.
- Run an Nginx reverse proxy that forwards to each service, enforces Basic Auth, and serves HTTPS.
- Validate access and HTTP → HTTPS redirection.

---

## 1) Hosts file

Open PowerShell as Administrator and edit the hosts file, or run Notepad as Admin:

```powershell
# Open hosts file in Notepad (run PowerShell as Administrator)
notepad C:\Windows\System32\drivers\etc\hosts
```

Add these lines:

```
127.0.0.1 grafana.local
127.0.0.1 jenkins.local
```

Save and close.

## 2) Workspace layout

Create a small folder structure for proxy configuration, certificates and auth files (run from your project root in PowerShell):

```powershell
mkdir -Force .\proxy
mkdir -Force .\proxy\conf.d
mkdir -Force .\proxy\certs
mkdir -Force .\proxy\auth
```

## 3) Generate a self-signed certificate (SAN)

Create a certificate that includes both `grafana.local` and `jenkins.local` as SANs. If `openssl` is not available from PowerShell, run these steps in WSL or Git Bash.

```powershell
# Create a CSR config file (writes to .\proxy\certs\csr.conf)
@"
[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[dn]
C=US
ST=State
L=City
O=DevOps
OU=Local
CN = grafana.local

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = grafana.local
DNS.2 = jenkins.local
"@ | Out-File -Encoding ascii .\proxy\certs\csr.conf

# Generate private key
openssl genrsa -out .\proxy\certs\local.key 2048

# Generate CSR
openssl req -new -key .\proxy\certs\local.key -out .\proxy\certs\local.csr -config .\proxy\certs\csr.conf

# Self-sign certificate (valid 10 years here)
openssl x509 -req -in .\proxy\certs\local.csr -signkey .\proxy\certs\local.key -out .\proxy\certs\local.crt -days 3650 -extensions req_ext -extfile .\proxy\certs\csr.conf
```

Optional: combine into a `.pem` if needed by some tools:

```powershell
copy .\proxy\certs\local.crt .\proxy\certs\local.pem
Get-Content .\proxy\certs\local.key | Out-File -Append -Encoding ascii .\proxy\certs\local.pem
```

Tip: import `local.crt` to your OS/browser trusted store to avoid browser warnings.

## 4) Create Basic Auth credentials (htpasswd)

Generate an `htpasswd` (bcrypt) file using the `httpd` container so you don't need `htpasswd` installed locally. Replace `admin` and `StrongPass123` with your own username/password.

```powershell
docker run --rm httpd:2.4 htpasswd -Bbn admin StrongPass123 > .\proxy\auth\htpasswd
Get-Content .\proxy\auth\htpasswd
```

## 5) Run Grafana and Jenkins (Docker)

Run Grafana:

```powershell
docker run -d --name grafana -e "GF_SECURITY_ADMIN_PASSWORD=admin" -p 3000:3000 grafana/grafana:latest
```

Run Jenkins (LTS):

```powershell
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```

Wait a minute for Jenkins to initialize. Check logs with:

```powershell
docker logs -f jenkins
```

## 6) Nginx reverse proxy configuration

Create file `.\proxy\conf.d\reverse.conf` with the following content:

```
limit_req_zone $binary_remote_addr zone=req_limit_zone:10m rate=5r/s;


server {
    listen 80;

    server_name grafana.local jenkins.local;
    return 301 https://$host$request_uri;

}


# Grafana HHTPS server Block
server {
    listen 443 ssl http2;
    server_name grafana.local;

     # Add baisc auth here
    auth_basic "Restricted Grafana Access";
    auth_basic_user_file /etc/nginx/.htpasswd;

    ssl_certificate /etc/nginx/certs/local-proxy.crt;
    ssl_certificate_key /etc/nginx/certs/local-proxy.key;
    ssl_protocols TLSv1.2 TLSv1.3;

    location / {
        proxy_pass http://grafana:3000/;
        proxy_set_header Host $host;
        # ... other headers ...
    }
}


# Jenkins HTTPS Server Block
server {
    listen 443 ssl http2;
    server_name jenkins.local;

     # Add basic auth here
    auth_basic "Restricted Jenkins Access";
    auth_basic_user_file /etc/nginx/.htpasswd;

    ssl_certificate /etc/nginx/certs/local-proxy.crt;
    ssl_certificate_key /etc/nginx/certs/local-proxy.key;
    ssl_protocols TLSv1.2 TLSv1.3;

    location / {
        limit_req zone=req_limit_zone burst=10 nodelay;
        
        proxy_pass http://jenkins:8080/;
        proxy_set_header Host $host;
        # ... other headers ...

        # *** THIS IS THE CRITICAL LINE TO ADD ***
        proxy_set_header Authorization "";

    }
}
```

Notes:
- `host.docker.internal` lets the Nginx container reach host-mapped ports on Windows. If you run all services inside a Docker network, use container names and internal ports instead.
- `auth_basic_user_file` points to the `htpasswd` file generated earlier.

Run the Nginx container (from the repository root where `.\proxy` exists):

```powershell
# If your current path has spaces, wrap paths in quotes.
docker run -d --name reverse-proxy -p 80:80 -p 443:443 -v "${PWD}\proxy\conf.d:/etc/nginx/conf.d:ro" -v "${PWD}\proxy\certs:/etc/nginx/certs:ro" -v "${PWD}\proxy\auth:/etc/nginx/auth:ro" --restart unless-stopped nginx:stable
```

Alternative (recommended): create a Docker network `proxy-net`, attach all containers to it, and update `proxy_pass` to `http://grafana:3000` and `http://jenkins:8080` inside the Nginx config.

```powershell
# Create network
docker network create proxy-net

# Run Grafana, Jenkins and Nginx attached to proxy-net
# In this mode, update proxy_pass upstreams to use container names.
```

## 7) Validate configuration

Using PowerShell `curl` (alias for `Invoke-WebRequest`):

```powershell
# Check HTTP -> HTTPS redirect
curl -I http://grafana.local

# Access Grafana via HTTPS (skip cert verification if self-signed)
curl -k https://grafana.local

# Access Jenkins via HTTPS with Basic Auth
curl -k -u admin:StrongPass123 https://jenkins.local
```

Browser validation:
- Visit `https://grafana.local` — Grafana UI should appear (you may still log in with Grafana credentials).
- Visit `https://jenkins.local` — Nginx will prompt for Basic Auth first, then Jenkins UI (initial unlock may be required for new Jenkins).

If you see certificate warnings, import `.\proxy\certs\local.crt` into Windows Trusted Root Authorities or your browser trust store.

## 8) Secure Jenkins specifics

- Nginx Basic Auth prevents reaching Jenkins before the Jenkins login screen. Configure Jenkins internal security (users, roles) in Jenkins for best control.
- If you want to rely solely on Jenkins' own auth, remove `auth_basic` for the Jenkins server block.

## 9) Troubleshooting

- Nginx logs: `docker logs -f reverse-proxy`
- Confirm services are listening:

```powershell
netstat -ano | Select-String ":80|:443|:3000|:8080"
```
- If Nginx shows `502 Bad Gateway`, verify Grafana/Jenkins are reachable at the addresses used in `proxy_pass` (either `host.docker.internal:PORT` or container name:port).
- Ensure the `htpasswd` file is readable by the Nginx container (volume mount path is correct).
- Ensure the SAN entries in the certificate include both domains.

## 10) Cleanup

Stop and remove containers and optionally volumes:

```powershell
docker stop reverse-proxy grafana jenkins
docker rm reverse-proxy grafana jenkins
docker network rm proxy-net  # if created
docker volume rm jenkins_home  # optional
```

## 11) Optional: docker-compose example

Below is a skeleton `docker-compose.yml` you can adapt. If using compose and a custom network, update `reverse.conf` to proxy to `http://grafana:3000` and `http://jenkins:8080`.

```yaml
version: "3.8"
services:
  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    networks:
      - proxy-net
    restart: unless-stopped

  jenkins:
    image: jenkins/jenkins:lts
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - jenkins_home:/var/jenkins_home
    networks:
      - proxy-net
    restart: unless-stopped

  nginx:
    image: nginx:stable
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./proxy/conf.d:/etc/nginx/conf.d:ro
      - ./proxy/certs:/etc/nginx/certs:ro
      - ./proxy/auth:/etc/nginx/auth:ro
    networks:
      - proxy-net
    restart: unless-stopped

volumes:
  jenkins_home:

networks:
  proxy-net:
    driver: bridge

```

## Issues Encountered and Resolutions

During this setup, several common Docker and Nginx configuration pitfalls were encountered. Here is a summary of the issues and their respective solutions:

**Issue 1: connect() failed (111: Connection refused) while connecting to upstream**
This error occurred because Nginx, running inside one container, attempted to connect to services on 127.0.0.1 (localhost), which refers only to the inside of the Nginx container itself, not the separate Grafana/Jenkins containers.

**Resolution:** The proxy_pass directive in default.conf was updated to use the Docker Compose service name (http://grafana:3000/ and http://jenkins:8080/), leveraging Docker's built-in DNS resolution.

**Issue 2: req: Can't open "./certs/local-proxy.key" for writing, No such file or directory**
This error happened when attempting to generate SSL certificates using openssl because the target directory (nginx-config/certs/) did not exist at the time the command was run.

**Resolution:** The directory was created first using mkdir -p nginx-config/certs before running the openssl req command.


**Issue 3: "You don't have administrator permission to save this file" (Windows hosts file)**
When attempting to edit the Windows /etc/hosts file (to map *.local domains to 127.0.0.1), Notepad gave a permissions error upon saving.

**Resolution:** The text editor (Notepad or PowerShell) had to be launched using "Run as administrator" before opening the hosts file to gain the necessary elevated privileges to save changes to a system-protected file.


**Issue 4: Browser accessible via curl but not browser**
The command line curl https://grafana.local worked on the host machine, but the web browser showed a "site cannot be reached" error.

**Resolution:** The primary fix involved clearing the browser's cache (using Incognito mode or a hard refresh) to bypass old, cached DNS entries or HSTS settings that were interfering with the connection.

**Issue 5: Jenkins Authentication Not Working**
Basic Auth worked for Grafana, but Jenkins either ignored the login prompt or entered an authentication loop, returning errors in the Nginx logs.

**Resolution:** Jenkins security configuration conflicted with Nginx’s attempt to pass authentication headers. The Nginx configuration was modified to explicitly clear the header for Jenkins requests using proxy_set_header Authorization ""; within the Jenkins location block.


## Security notes

- Self-signed certificates are acceptable for local testing only.
- Consider using a CA-signed certificate (Let's Encrypt) and a secure authentication mechanism (OAuth, LDAP, SSO) for production.
- Avoid storing plaintext passwords in scripts — use secrets management solutions.

## Validation checklist

- Hosts entries added for `grafana.local` and `jenkins.local`.
- Containers: `grafana`, `jenkins`, `reverse-proxy` running.
- HTTPS works for both domains (certificate present).
- HTTP requests redirect to HTTPS.
- Basic Auth enforced at the proxy for both services.

---
