## Solution Day 5 Task

1. Created a GitHub repository named **python-webapp** for the challenge.
  
   <img width="3198" height="1740" alt="python-webapp" src="https://github.com/user-attachments/assets/e634431a-8bb7-4ff1-a842-99975e94e70f" />

---

2. Created a app.py file in the repo and add the below code.

   *app.py*

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

 ![app.py](https://github.com/AshuApurva14/python-webapp/blob/c70662a3642a1431d73e5424b5374ca5d5339701/app.py)

---

3. Created a Dockerfile with below code.

*Dockerfile*

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

![Dockerfile](Day_5_3.png)

---

4. Builds and pushes a Docker image to Docker Hub.

  1. Prerequisite for build and push docker image
     
     - You must have a **DockerHub account**.
     - If not then, Please sign up and create a Dockerhub account (via **Google Gmail** or **GitHub Account**)
     - Once you have the account, login and create a repository inside the dockerhub. This repo will be used further to push and store your images.

     
  2. Create *.github/workflows* directory at root of the repository.

     - Under the same directory create a GitHub Actions workflow file.

     - Go to .github > workflows > cicd.yaml.

     cicd.yaml
```
      name: Build, test and deploy Python webapp


      on:
        workflow_dispatch:  # For Manual trigger from any branch


      jobs:
         build-and-test:           # Job name
         runs-on: [ubuntu_latest]  # GitHub runner configuration



        steps:
          
          - name: Checkout       # checkout the repository
            uses: actions/checkout@v5.0.0


          - name:

```
  **Refer below:**

  ![gha workflow](Day_5_4.png)

    - Now let's test the workflow execution. Go to *action* tab select the workflow from the left side.

    - Then you will be able to see a *Run workflow* with dropdown list (branch details), select the branch and **Run Worklfow** to trigger the workflow.


  ![action tab](Day_5_5.png)


   - After triggering, go to the logs of the workflow to see how the execution is hapening.


   ![workflow logs](Day_5_6.png)

---


  - first step, we have added is linting the code. It is very crucial to check and format the code.



    

