# Solution: GitHub Actions CI/CD Pipeline Implementation

## 1. Project Components and Their Purpose

### Application Components
- **Flask Application**: Lightweight web framework for Python
- **Docker Container**: Ensures consistent environment across deployments
- **GitHub Actions**: Automates testing, building, and deployment
- **Security Scanning**: Protects application from vulnerabilities

## 2. Step-by-Step Implementation

### 2.1 Repository Setup
1. Created GitHub repository **python-webapp**
   <img width="3198" height="1740" alt="python-webapp" src="https://github.com/user-attachments/assets/e634431a-8bb7-4ff1-a842-99975e94e70f" />

   **Why**: Centralized version control and collaboration platform

### 2.2 Application Development

#### Flask Application (app.py)
```python
from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Welcome to Season 2! You are learning GitHub Actions."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```
**Purpose**:
- Creates a simple web endpoint
- Runs on all network interfaces (0.0.0.0)
- Uses port 5000 for HTTP access

#### Dockerfile Configuration

[Dockerfile](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/Dockerfile)

<img width="3200" height="1872" alt="Dockerfile" src="https://github.com/user-attachments/assets/439d744f-cddf-4c8f-b92c-2adf899a4dcd" />

```Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY app.py /app
RUN pip install flask
EXPOSE 5000
CMD ["python", "app.py"]
```
**Purpose**:
- Uses lightweight Python image for smaller size
- Creates isolated application environment
- Installs only necessary dependencies
- Exposes port for web access

### 2.3 CI/CD Pipeline Components

 [cicd.yaml](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/.github/workflows/cicd.yml)

  <img width="3200" height="1710" alt="cicd.yaml" src="https://github.com/user-attachments/assets/eda7c81d-032a-4c72-8022-79f18ee179bd" />

#### 1. Code Quality (Linting)

```yaml
- name: Run Ruff linter
  uses: astral-sh/ruff-action@v3.5.1
```
**Why Important**:
- Ensures consistent code style
- Catches syntax errors early
- Improves code maintainability
- Reduces review time

#### 2. Security Scanning

[gitleaks.yml](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/.github/workflows/gitleaks.yaml)

<img width="3200" height="1684" alt="Image" src="https://github.com/user-attachments/assets/aae261e3-1617-4996-ac70-8bd5a161998a" />

```yaml
- name: Run Gitleaks
  uses: gitleaks/gitleaks-action@v2
```
**Purpose**:
- Detects hardcoded secrets
- Prevents credential exposure
- Maintains security best practices


#### 3. CodeQL Security Analysis

<img width="3200" height="1642" alt="Image" src="https://github.com/user-attachments/assets/64a615c2-566d-4c69-92b5-0ce4d2ef9dcf" />

```yaml
- name: Initialize CodeQL
  uses: github/codeql-action/init@v2
  with:
    languages: python

- name: Perform CodeQL Analysis
  uses: github/codeql-action/analyze@v2
```

**Purpose**:
- Static Code Analysis
- Identifies security vulnerabilities
- Detects common coding errors
- Provides detailed security reports

**Benfits**:
- Automated security review
- Early vulnerability detection
- Code Quality improvement
- Complaiance requrements


#### 3. Docker Build Process

<img width="3200" height="1762" alt="Image" src="https://github.com/user-attachments/assets/6190fccf-55f2-4136-b981-bec880c14be4" />

```yaml
- name: Build and push Docker image
  uses: docker/build-push-action@v4
  with:
    context: .
    push: true
    tags: ${{ secrets.DOCKER_USERNAME }}/python-webapp:latest
```
**Why Important**:
- Creates reproducible builds
- Ensures consistent deployments
- Enables easy distribution
- Maintains version control

#### 4. Automated Testing

<img width="3194" height="1428" alt="Image" src="https://github.com/user-attachments/assets/c3a9dc34-fef0-4320-9329-ae76c251d41c" />

```yaml
- name: Run Tests
  run: |
    python -m pytest tests/
    coverage run -m pytest
```
**Benefits**:
- Validates functionality
- Ensures quality code
- Prevents regressions
- Measures code coverage

#### 5. Image Vulnerability scanning

<img width="3200" height="1748" alt="Image" src="https://github.com/user-attachments/assets/64299d93-8ed9-40db-804c-78f16afff18b" />

```yaml
- name: Trivy Scanner
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: ${{ secrets.DOCKER_USERNAME }}/python-webapp:latest
```
**Purpose**:
- Scans for vulnerabilities
- Checks dependencies
- Ensures container security
- Provides security reports

#### 6. Deployment & Application Status

<img width="3200" height="1744" alt="Image" src="https://github.com/user-attachments/assets/4f74c7b7-7a9b-4e3e-b138-9d0dbb740a9b" />


```yaml
- name: Deploy Application
  run: |
    docker run -d -p 5000:5000 ${{ secrets.DOCKER_USERNAME }}/python-webapp:latest

- name: Health Check
  run: |
    curl -s http://localhost:5000/health
```

**Benefits**:
- Automates deployment process
- Validates application health
- Ensures availability
- Monitors performance

#### 7. Email Notification 

<img width="3200" height="1702" alt="Image" src="https://github.com/user-attachments/assets/49babda4-e9d0-4580-8851-b9305bd39a81" />

```yaml
  - name: Send deployment status email
          uses: dawidd6/action-send-mail@v3
          with:
              server_address: smtp.gmail.com
              server_port: 465
              username: ${{ secrets.EMAIL_USERNAME }}
              password: ${{ secrets.EMAIL_PASSWORD }}
              subject: "🚀 Deployment Status: ${{ steps.deployment_status.conclusion }}"
              to: "devopssre5@gmail.com"
              from: GitHub Actions
              body: |
                Hello,
                
                Deployment for *${{ github.repository }}* on commit ${{ github.sha }} has finished.
                Status: **${{ job.status }}**

                Application is running successfully!.

                Triggered by: ${{ github.actor }}
```


## 3. Best Practices Implemented

### Security
1. **Secret Management**
   - Using GitHub Secrets
   - Environment variables
   - No hardcoded credentials

### Monitoring
1. **Health Checks**
   ```yaml
   health_check:
     curl -s http://localhost:5000/health
   ```
   - Validates application status
   - Ensures continuous operation

### Automation
1. **Dependency Updates**
   ```yaml
   - package-ecosystem: "pip"
     directory: "/"
     schedule:
       interval: "weekly"
   ```
   - Regular security updates
   - Automated PR creation
   - Keeps dependencies current

## 4. Development Workflow

### Local Setup
```bash
# Clone and setup
git clone https://github.com/<username>/python-webapp.git
python -m venv venv
source venv/bin/activate

# Install and run
pip install flask
python app.py
```

### Container Testing
```bash
# Build locally
docker build -t python-webapp .

# Test container
docker run -p 5000:5000 python-webapp
```


## Challenges Faced & Solutions

### 1. Module Import Error

**Challenge**: 
Test failures occurred due to module import issues during CI pipeline execution:
```python
ModuleNotFoundError: No module named 'app'
```

**Solution**:
1. **Directory Structure**:
```bash
python-webapp/
├── app/
│   ├── __init__.py
│   └── app.py
├── tests/
│   ├── __init__.py
│   └── test_app.py
└── requirements.txt
```

2. **PYTHONPATH Configuration**:
```yaml
# filepath: .github/workflows/cicd.yml
- name: Set Python Path
  run: |
    echo "PYTHONPATH=$PYTHONPATH:${{ github.workspace }}" >> $GITHUB_ENV
```

3. **Test Configuration**:
```python
# filepath: tests/test_app.py
import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
```

### 2. Email Notifications

**Challenge**: 
Gmail SMTP authentication failures when sending deployment notifications.

**Solution**:
1. **App-specific Password Setup**:
```yaml
# filepath: .github/workflows/cicd.yml
- name: Send Email Notification
  env:
    SMTP_SERVER: smtp.gmail.com
    SMTP_PORT: 587
    SMTP_USERNAME: ${{ secrets.GMAIL_USERNAME }}
    SMTP_PASSWORD: ${{ secrets.GMAIL_APP_PASSWORD }}
  run: |
    python ./scripts/send_notification.py
```

2. **Alternative GitHub Notifications**:
```yaml
  - name: Send deployment status email
          uses: dawidd6/action-send-mail@v3
          with:
              server_address: smtp.gmail.com
              server_port: 465
              username: ${{ secrets.EMAIL_USERNAME }}
              password: ${{ secrets.EMAIL_PASSWORD }}
              subject: "🚀 Deployment Status: ${{ steps.deployment_status.conclusion }}"
              to: "devopssre5@gmail.com"
              from: GitHub Actions
              body: |
                Hello,
                
                Deployment for *${{ github.repository }}* on commit ${{ github.sha }} has finished.
                Status: **${{ job.status }}**

                Application is running successfully!.

                Triggered by: ${{ github.actor }}

```

### 3. Docker Security

**Challenge**: 
Container vulnerability scan revealed multiple security issues.

**Solution**:
1. **Trivy Scanning Implementation**:
```yaml
# filepath: .github/workflows/cicd.yml
- name: Run Trivy vulnerability scanner
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: '${{ secrets.DOCKER_USERNAME }}/python-webapp:${{ github.sha }}'
    format: 'table'
    exit-code: '1'
    ignore-unfixed: true
    severity: 'CRITICAL,HIGH'
```

2. **Minimal Base Image**:
```dockerfile
# filepath: Dockerfile
FROM python:3.9-slim-buster as builder

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM gcr.io/distroless/python3
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app
COPY . .
USER nonroot
CMD ["python", "app.py"]
```

3. **Automated Dependencies Update**:
```yaml
# filepath: .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
    labels:
      - "dependencies"
      - "security"
    ignore:
      - dependency-name: "*"
        update-types: ["version-update:semver-patch"]
```

### Best Practices Implemented:
1. Use of multi-stage builds to reduce image size
2. Regular security scanning in CI pipeline
3. Automated dependency updates
4. Principle of least privilege (nonroot user)
5. Vulnerability management workflow



# CI/CD Pipeline Architecture

```mermaid
%%{init: {
  'theme': 'neutral',
  'themeVariables': {
    'fontFamily': 'arial',
    'fontSize': '16px',
    'primaryColor': '#1f77b4',
    'primaryTextColor': '#fff',
    'primaryBorderColor': '#123752',
    'lineColor': '#123752',
    'secondaryColor': '#4a90e2',
    'tertiaryColor': '#6cc04a'
  }
}}%%

flowchart TB
    classDef default fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef pipeline fill:#e1f3fe,stroke:#1f77b4,stroke-width:2px;
    classDef security fill:#fff3e0,stroke:#ff9800,stroke-width:2px;
    classDef deployment fill:#e8f5e9,stroke:#4caf50,stroke-width:2px;

    subgraph IDE["Development Environment"]
        DEV[Developer] --> |Git Push| REPO[GitHub Repository]
    end

    subgraph CI["Continuous Integration"]
        direction TB
        REPO --> PIPE[GitHub Actions Pipeline]
        
        subgraph Quality["Quality Gates"]
            direction LR
            LINT[Ruff Linter] --> 
            TEST[Unit Tests] -->
            COV[Coverage Check]
        end

        subgraph Security["Security Checks"]
            direction LR
            GITLEAKS[Gitleaks] -->
            CODEQL[CodeQL Analysis] -->
            TRIVY[Trivy Scanner]
        end
    end

    subgraph CD["Continuous Deployment"]
        direction TB
        DHUB[Docker Hub] --> 
        DEPLOY[Deploy Container] -->
        HEALTH[Health Check] -->
        NOTIFY[Status Notification]
    end

    PIPE --> Quality
    Quality --> Security
    Security --> CD

    class IDE,CI,CD default;
    class Quality,Security pipeline;
    class GITLEAKS,CODEQL,TRIVY security;
    class DHUB,DEPLOY,HEALTH,NOTIFY deployment;