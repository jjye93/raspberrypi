#!/usr/bin/bash

echo "----------------------------------------------------------------"
echo "Commence Argon One Setup"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argon1.sh | bash
echo "----------------------------------------------------------------"
echo "Argon One Setup Completed Successfully"
echo "----------------------------------------------------------------"

# Call next script
echo "Calling Rpi-connect Setup..."
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/breakdown-script/rpi-connect.sh | sudo bash
