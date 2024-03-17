#!bin/bash

sudo apt-get update -y
sleep 10
sudo apt-get install apache2 -y
sudo systemctl start apache2