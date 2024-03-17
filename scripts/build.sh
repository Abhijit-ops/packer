#!bin/bash

sudo apt-get update -y
sudo apt-get install apache2-bin -y
sudo apt-get install  mime-support -y
sudo apt-get install apache2 -y
sudo systemctl start apache2