#!/usr/bin/env bash

    set -xe


    # System Health Check script 

    # Directory and per-run report file (timestamped)
    SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
    REPORT_DIR="$SCRIPT_DIR/reports"
    mkdir -p "$REPORT_DIR"
    REPORT_FILE="$REPORT_DIR/report-$(date '+%Y%m%d_%H%M%S').txt"
    # create/clear the report file for this run
    : > "$REPORT_FILE"
    # update a stable symlink to the latest report (full path)
    ln -sf "$REPORT_FILE" "$REPORT_DIR/latest-report.txt"

    #--------------------------------------------------------------------------------------------------------------------------------------------------------------#

    # Check Disk Usage

    function check_disk_usage() {
        
        disk_usage_status=$(df -h)

    echo -e "\n #==================================== Disk usage Status ===================================# \n\n" >> "$REPORT_FILE"

    echo -e "$disk_usage_status \n\n" >> "$REPORT_FILE"

    echo -e "Disk usages check completed \n" >>  "$REPORT_FILE"

    echo -e "#=============================================================================================# \n\n" >> "$REPORT_FILE"
        
    }

    #--------------------------------------------------------------------------------------------------------------------------------------------------------------#

    # Monitor Running Processes

    function monitor_running_services() {

        check_process=$(systemctl list-units --type=service --state=running )


    echo -e "\n #=============================== Running Services Status ==================================# \n\n " >> "$REPORT_FILE"

    echo -e "$check_process \n\n" >> "$REPORT_FILE"

    echo -e "Monitor Running Services check completed \n" >> "$REPORT_FILE" 

    echo -e "#=============================================================================================# \n\n" >> "$REPORT_FILE"

    }


    #---------------------------------------------------------------------------------------------------------------------------------------------------------------#

    #  Check Memory usage Status

    function memory_usage() {
       
        memory_status=$(free -h)
        
    echo -e "\n #================================== Memeory Usage Status ===================================# \n\n " >> "$REPORT_FILE"
    echo -e "$memory_status \n\n" >> "$REPORT_FILE"
    echo -e "Memory Usages check completed \n" >> "$REPORT_FILE"

    echo -e "#===============================================================================================# \n\n" >> "$REPORT_FILE"


    }


    #-----------------------------------------------------------------------------------------------------------------------------------------------------------------#

    # Check CPU Usage status

    function cpu_usage() {

        cpu_status=$(top -bn1 )

    echo -e "\n #=================================== CPU usage Status ======================================# \n\n " >> "$REPORT_FILE"

    echo -e "$cpu_status \n\n" >> "$REPORT_FILE"
        
    echo -e "CPU Usages check completed \n" >> "$REPORT_FILE"

    echo -e "#==============================================================================================# \n\n" >> "$REPORT_FILE"
        
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
        APP_PASSWORD="Your password" # Use a Google App Password, not your account password
        CURRENT_DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")
        SUBJECT="System Health Report - $CURRENT_DATE_TIME"
        BODY="Please find the latest System Health Report file attached."
    ATTACHMENT="$REPORT_FILE"

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