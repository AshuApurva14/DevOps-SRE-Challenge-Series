#!/usr/bin/env bash

# This script is used to create a directory for next 30 days for my DevOps SRE Daily Challenge.

no_of_dir_to_create=$1
path_to_create="/workspaces/My-DevOps-SRE-Daily-Challenge/challenege"

for dir in $(seq 2 $no_of_dir_to_create)
do
    dir_name=day_$dir
    dir_path="$path_to_create/$dir_name"
    if [[ -d  "$dir_path" ]]; then
        echo "Directory $dir_path already exists" >&2
        exit 1
        
    else
       mkdir -p "$dir_path"
       echo "Created directory $dir_path"
    fi
done

