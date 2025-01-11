#!/usr/bin/bash

echo "----------------------------------------------------------------"
echo "Argon Neo"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argon-eeprom.sh | bash && curl https://download.argon40.com/argonneo5.sh | bash
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"

# Call next script
#echo "Calling Rpi-connect Setup..."
#curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/breakdown-script/rpi-connect.sh | sudo bash
