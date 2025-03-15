#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Update & Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install bash curl sudo git -y
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
sleep 5s
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/argonneo.sh | sudo bash
