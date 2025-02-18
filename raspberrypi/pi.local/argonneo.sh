#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Commence Argon Neo Setup"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argon-eeprom.sh | bash && curl https://download.argon40.com/argonneo5.sh | bash
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
sleep 5s
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/docker.sh | sudo bash
