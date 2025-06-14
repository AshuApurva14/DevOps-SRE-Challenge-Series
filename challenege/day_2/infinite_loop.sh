#!/usr/bin/env bash

set -euo pipefail

# Infinte loop with break test
# Real world scenario:
# Wait til a service readiness!

MAX_RETRIES=20
RETRY_COUNT=0


while true; do
    
     echo "Checking the service readiness!..."
     HTTP_STATUS=$(curl -s -o /dev/null -w  "%{http_code}" https://www.ashutoshapurva.com)

     if [[ "$HTTP_STATUS" == "200" ]]; then
        echo "Service is ready!"
        break
    else
        echo "Service is not ready yet. Retrying in 5 seconds.....!"
        sleep 5
        if [[ $RETRY_COUNT -ge $MAX_RETRIES ]]; then
            echo "Max retries reached. Exiting..."
            exit 1
        fi

    fi
done







    
