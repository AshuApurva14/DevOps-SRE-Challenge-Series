#!/usr/bin/env python

'''
👉 Problem Secanrio no - 3

Auto pull docker image 

'''

import docker

def pull_docker_image():
    client=docker.from_env()
    image_list=['redis:latest', 'nginx:latest']
    for img in image_list:
        print("I am pulling image {}".format(img))
        client.images.pull(img)
        


if __name__ == "__main__":
    pull_docker_image()