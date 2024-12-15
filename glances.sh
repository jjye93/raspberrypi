#!/usr/bin/bash
set -e
echo "----------------------------------------------------------------"
echo "Commence Glances Setup"
echo "----------------------------------------------------------------"
sudo apt-get install glances -y || handle_error
sudo systemctl enable glances || handle_error
sudo systemctl start glances || handle_error
echo "----------------------------------------------------------------"
echo "Glances setting completed and host at http://localhost:61208"
echo "----------------------------------------------------------------"
echo " "
echo "Calling root-ssh account Setup"
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/breakdown-script/ssh.sh | sudo bash
