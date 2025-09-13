## Solution Day 5 Task

1. Created a GitHub repository named **python-webapp** for the challenge.
  
   <img width="3198" height="1740" alt="python-webapp" src="https://github.com/user-attachments/assets/e634431a-8bb7-4ff1-a842-99975e94e70f" />

---

2. Created a app.py file in the repo and add the below code.

   [app.py](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/app.py)


```
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Welcome to Season 2! You are learning GitHub Actions."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```


  <img width="3198" height="1866" alt="app.py" src="https://github.com/user-attachments/assets/2f881099-07b8-4935-b828-15e89395e2b3" />

  
---

3. Created a Dockerfile with below code.

[Dockerfile](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/Dockerfile)

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

<img width="3200" height="1872" alt="Dockerfile" src="https://github.com/user-attachments/assets/439d744f-cddf-4c8f-b92c-2adf899a4dcd" />

---

4. Builds and pushes a Docker image to Docker Hub.

  1. Prerequisite for build and push docker image
     
     - You must have a **DockerHub account**.
     - If not then, Please sign up and create a Dockerhub account (via **Google Gmail** or **GitHub Account**)
     - Once you have the account, login and create a repository inside the dockerhub. This repo will be used further to push and store your images.

     
  2. Create *.github/workflows* directory at root of the repository.

     - Under the same directory create a GitHub Actions workflow file.

     - Go to .github > workflows > cicd.yaml.

      [cicd.yaml](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/.github/workflows/cicd.yml)


  **Refer below:**

   <img width="3200" height="1710" alt="cicd.yaml" src="https://github.com/user-attachments/assets/eda7c81d-032a-4c72-8022-79f18ee179bd" />

    - Now let's test the workflow execution. Go to *action* tab select the workflow from the left side.

    - Then you will be able to see a *Run workflow* with dropdown list (branch details), select the branch and **Run Worklfow** to trigger the workflow.


  <img width="3200" height="1732" alt="python_workflow" src="https://github.com/user-attachments/assets/99fb8fa4-1763-4a22-8c65-c290d3deba32" />


   - After triggering, go to the logs of the workflow to see how the execution is hapening.


   <img width="3200" height="1814" alt="python_workflow_logs" src="https://github.com/user-attachments/assets/ad2d67b9-952d-40fe-84a9-fac4f5094dfc" />

---


  - first step, we have added is linting the code. It is very crucial to check and format the code.



    

