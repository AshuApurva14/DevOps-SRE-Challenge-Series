#!/usr/bin/env bash

set -e


# Send a system health report every hour


cron_job="0 4 * * *" /workspaces/DevOps-SRE-Challenge-Series/DevOps_SRE_Challenge_Season_2/Day_1/check_up.sh

# Add to existing crontab
(crontab -l 2>/dev/null; echo "$cron_job") | crontab -






