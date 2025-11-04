#!/usr/bin/env bash

set -e


# System Health Check script 

#--------------------------------------------------------------------------------------------------------------------------------------------------------------#

# Check Disk Usage

function check_disk_usage() {
     
    disk_usage_status=$(df -h)

    echo "$disk_usage_status" >> report.txt

    echo -e "#===================== Current status of Disk usage ======================# \n\n$disk_usage_status \n\n"
    
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------#

# Monitor Running Processes

function monitor_running_services() {

    check_process=$(systemctl list-units --type=service --state=running )

    echo "$check_process" >> report.txt

    echo -e "#====================== Current running process =======================# \n\n $check_process \n\n "
}


#---------------------------------------------------------------------------------------------------------------------------------------------------------------#

#  Check Memory usage Status

function memory_usage() {
   
     memory_status=$(free -h)

     echo "$memory_status" >> report.txt

     echo -e "#=============================== Current memory status ==========================# \n\n $memory_status \n\n "

}


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------#

# Check CPU Usage status

function cpu_usage() {

      cpu_status=$(top -bn1 )

      echo "$cpu_status" >> report.txt

      echo -e "#============================= Current status of CPU =============================# \n\n $cpu_status \n\n"
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------#

# Send a Comprehensive Email

function send_email() {
       
      RECIPIENT="devopssre5@gmail.com"
      SUBJECT="System Health Report"
      ATTACHMENT_FILE="/workspaces/DevOps-SRE-Challenge-Series/DevOps_SRE_Challenge_Season_2/Day_1/report.txt"
      BODY="Please find the latest System Health Report file attached."


    # Send the email with an attachment
      mail -s "$SUBJECT" "$RECIPIENT" < "$ATTACHMENT_FILE"
      echo -e "\n\n"

      echo -e "System health Report email  has been send successfully\n\n"
    
}


while true;  do

    echo -e "#---------------- System Health Check -----------------------#\n"
    echo "1. Check Disk Usage"
    echo "2. Monitor Running Processes"
    echo "3. Assess Memory Usage"
    echo "4. Evaluate CPU Usage"
    echo "5. Send a Comprehensive Report over Email"
    
    echo -e "\n#------------------------------------------------------------#\n\n "

    
    read -p "Enter your choice [1:3] " choice_var

    case "$choice_var" in 
        1) 
        
            check_disk_usage
            ;;

        2) 
            monitor_running_services
            ;;

        3) 
            memory_usage
            ;;

        4)
           cpu_usage
           ;;

        5)
           send_email
           ;;

        *)

            echo "Sorry! Selected option does not exist. Please select appropriate option"
            exit 1
            ;;

    esac

done 