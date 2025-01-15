#!/usr/bin/bash
echo "mosquitto"
sudo apt-get update && sudo apt-get full-upgrade -y
sudo apt-get install mosquitto -y
sudo systemctl stop mosquitto
sudo mkdir -p /opt/mosquitto
sudo wget -o /opt/mosquitto/mosquitto.conf https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smart%20home/mosquitto/mosquitto.conf
sudo chmod 777 /opt/mosquitto/mosquitto.conf
sudo systemctl enable mosquitto.conf
mosquitto -v
echo "complete"
