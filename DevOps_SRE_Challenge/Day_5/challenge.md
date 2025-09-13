# Challenge Day 5

##  Theory Challenge

 1. What are the key differences between GitHub Actions and Jenkins?
   
     **Answer:**

     Key difference between GitHub Actions and Jenkins are following:

     - GitHub Actions provide Ease of Use and 

 2. Describe the general structure of a GitHub Actions workflow.

   


 3. How to manage variables and secrets in GitHub Actions?



 ## Practical Challenge

 ### Challenge Scenario:

   You are required to create a GitHub Actions workflow that:


  1. Builds and pushes a Docker image to Docker Hub.
  2. Deploys the application on GitHub Runners
  3. Validates that the application is running correctly.
  4. Sends an email notification with the deployment status.
  
  Provided Code:

     app.py

```
    from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Welcome to Season 2! You are learning GitHub Actions."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

    Dockerfile
    
```
    # Use official Python image
     FROM python:3.9-slim

    # Set working directory
    WORKDIR /app

    # Copy files
    COPY app.py /app

    # Install Flask
    RUN pip install flask

    # Expose port 5000
    EXPOSE 5000

    # Run Flask app
    CMD ["python", "app.py"]

```



 ## Challenges Faced & Solutions

### 1. Module Import Error
**Challenge**: Test failures due to module import issues
```
ModuleNotFoundError: No module named 'app'
```
**Solution**: 
- Ensure proper directory structure
- Add `__init__.py` files
- Configure PYTHONPATH in CI environment

### 2. Email Notifications
**Challenge**: Gmail SMTP authentication failures
**Solution**: 
- Use App-specific passwords
- Configure proper SMTP settings
- Alternative: Use GitHub notification settings

### 3. Docker Security
**Challenge**: Container vulnerabilities
**Solution**: 
- Implement Trivy scanning
- Use minimal base images
- Regular dependency updates with Dependabot
