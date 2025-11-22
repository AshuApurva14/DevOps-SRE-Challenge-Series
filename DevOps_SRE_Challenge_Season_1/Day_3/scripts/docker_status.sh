#!/usr/bin/env bash

set -e

echo -e "Docker Status system\n"

function list_docker_images() {
    echo -e "======================================= List of Docker images Available ===================================\n\n"
    IMAGES=$(docker images)

    echo -e "$IMAGES\n\n"

    echo -e "===========================================================================================================\n\n"

}


function monitor_running_containers(){
    echo -e "========================================= Monitor Running Containers =====================================\n\n"

    CONTAINERS=$(docker ps)

    echo -e "$CONTAINERS\n\n"

    echo -e "=============================================================================================================="
}

list_docker_images

monitor_running_containers
