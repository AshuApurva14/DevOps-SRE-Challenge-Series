#!/usr/bin/env bash

# Real world scenario:
# Wait til a service readiness!

while true; do
    
     echo "Checking the serice readiness!..."
     curl -i https://www.myservice.net/health | grep "200 OK" > /dev/null
     if [ $? -eq 0 ]; then
        echo "Service is ready!"
        break
    else
        echo "Service is not ready yet.Retrying in 5 seconds.....!"
        sleep 5
    fi
done





    
