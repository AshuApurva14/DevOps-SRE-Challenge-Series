#!/usr/bin/env bash

set -e



# Check Disk Usage

function check_disk_usage() {
     
    disk_usage_status=$(df -h)

    echo -e "Current status of Disk usage:\n$disk_usage_status"

}

check_disk_usage


# Monitor Running Processes

function monitor_running_services() {

    check_process=$(systemctl list-units --type=service --state=running )

    echo -e "Current running process:\n$check_process"
}

monitor_running_services

function memory_usage() {
   
     memory_status=$(free -h)

     echo -e "Current memory status:\n$memory_status"

}

memory_usage


function cpu_usage() {

      cpu_status=$(top )
}


cpu_usage


