#!/usr/bin/env bash

set -e

echo -e " Do you want to Create  the DevOps SRE Challege directory structure!\n Let's Create it, please enter day no ...."

# Challenges faced - on above line related to \n
 # Fix - 


DAY_COUNT=$1
DIR_PATH=/workspaces/DevOps-SRE-Challenge-Series/DevOps_SRE_Challenge_Season_2

for dir in $DAY_COUNT
do 

   mkdir -p $DIR_PATH/Day_$dir
   echo "Directory created successfully at $DIR_PATH"

done