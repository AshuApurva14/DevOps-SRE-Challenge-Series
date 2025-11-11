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
        
        echo "-------------Memeory Usage Status-----------" >> report.txt
        echo "$memory_status \n\n" >> report.txt

        

        echo -e "#=============================== Current memory status ==========================# \n\n $memory_status \n\n "

    }


    #-----------------------------------------------------------------------------------------------------------------------------------------------------------------#

    # Check CPU Usage status

    function cpu_usage() {

        cpu_status=$(top -bn1 )

        echo -e "#============================= Current status of CPU =============================# \n\n " >> report.txt

        echo -e "$cpu_status \n\n" >> report.txt
        
        echo "CPU Usages check completed" >> report.txt
        
    }

    function exit() {

           exit
    }

    #------------------------------------------------------------------------------------------------------------------------------------------------------------------#

    # Send a Comprehensive Email

    function send_email() {
           
        

        echo -e "Sending System health Report.......\n\n"

        SENDER="devopssre5@gmail.com"
        RECEIVER="aapurva74@gmail.com"
        APP_PASSWORD="crht xoag efdt feib" # Use a Google App Password, not your account password
        CURRENT_DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")
        SUBJECT="System Health Report - $CURRENT_DATE_TIME"
        BODY="Please find the latest System Health Report file attached."
        ATTACHMENT="/workspaces/DevOps-SRE-Challenge-Series/DevOps_SRE_Challenge_Season_2/Day_1/report.txt"

        python3 - <<PY
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import os

msg = MIMEMultipart()
msg['From'] = '${SENDER}'
msg['To'] = '${RECEIVER}'
msg['Subject'] = '${SUBJECT}'

msg.attach(MIMEText('${BODY}', 'plain'))

# Attachment
filename = os.path.basename('${ATTACHMENT}')
attachment = open('${ATTACHMENT}', 'rb')
part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition', 'attachment; filename= %s' % filename)
msg.attach(part)

try:
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login('${SENDER}', '${APP_PASSWORD}')
    server.send_message(msg)
    server.quit()
    print('Email sent successfully!\n\n')
except Exception as e:
    print(f'Something went wrong: {e}')
PY


    
    }


    while true;  do

        echo -e "#=================== System Health Check =======================#\n"
        echo "1. Check Disk Usage"
        echo "2. Monitor Running Processes"
        echo "3. Assess Memory Usage"
        echo "4. Evaluate CPU Usage"
        echo "5. Send a Comprehensive Report over Email"
        echo "6. Exit"
        
        echo -e "\n#============================================================#\n\n "
        

        read -p "Enter your choice [1:3] " choice_var
        echo -e "\n\n\n"


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

            6)  exit
                ;;

            *)

                echo "Sorry! Selected option does not exist. Please select appropriate option"
                exit 1
                ;;

        esac

    done 