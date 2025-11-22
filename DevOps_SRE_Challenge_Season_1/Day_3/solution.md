# Soluton - Day 3 Challenge: Multi-Service Reverse Proxy with Nginx

This is a complete soluton of this challenge, which consist of step by step process to setup and configure Grafana and Jenkins usng Docker images locally. Below are the following additional configurations done for make it more secure and robust.

- Configure Nginx Reverse Proxy
- Enable SSL 
- Secure Jenkins
- Validate Configuration

## My Steps:

- I have run and deployed grafana in my local using docker image and docker cil.

- Create a docker-compose.yaml file under path *grafana/docker-compose.yaml*
` mkdir grafana ---> cd grafana ---> vi docker-compose.yaml`

- Add below configs


 ```yaml
services:
  grafana:
    image: grafana/grafana-enterprise
    container_name: grafana
    restart: unless-stopped
    ports:
      - '3000:3000'

 ```

- Now, lets execute and run the config using ` docker compose up -d` command.


---

- Next, I will  deploy jenkins and it setup using docker image and docker cli.





