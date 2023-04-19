#!/bin/zsh
set -e

# Start nginx
service nginx start

# Setup ros environment
source /opt/ros/noetic/setup.zsh

# Run zsh
exec "$@"
