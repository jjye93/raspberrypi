#!/usr/bin/bash
set -e

echo "----------------------------------------------------------------"
echo "Commence Argon One Setup"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argon1.sh | bash || handle_error "Argon One Setup"
echo "----------------------------------------------------------------"
echo "Argon One Setup Completed Successfully"
echo "----------------------------------------------------------------"

# Call next script
echo "Calling Docker Setup..."
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/breakdown-script/docker.sh | sudo bash
