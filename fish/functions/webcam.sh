#!/bin/bash

sudo modprobe v4l2loopback
echo "v4l2loopback module enabled"

read -sp "Enter username: " USERNAME
echo
read -sp "Enter password: " PASSWORD
echo

ffmpeg -i http://$USERNAME:$PASSWORD@192.168.2.10:8080/video \
       -f v4l2 -pix_fmt yuv420p /dev/video10
