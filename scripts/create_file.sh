#!/usr/bin/env bash

set -euo pipefail

no_of_days=$1

create_files() {

   file_path=/workspaces/DevOps-SRE-Challenge-Series/DevOps_SRE_Challenge_Season_2
   

   create_file="$(touch $file_path/Day_$no_of_days/challenge.md $file_path/Day_$no_of_days/solution.md)"

   echo "Files successfully created"

}

create_files