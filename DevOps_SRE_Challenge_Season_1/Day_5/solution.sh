#!/usr/bin/env bash

set -e

awk '$N ~ /user/ { print }' ./user_activity.log