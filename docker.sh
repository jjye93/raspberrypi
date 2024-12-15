#!/usr/bin/bash
set -e

echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
sudo apt-get install -y docker.io docker-compose || handle_error
echo "----------------------------------------------------------------"
sudo usermod -aG docker admin || handle_error "Adding user to Docker group"
sudo systemctl enable docker.service || handle_error "Enabling Docker service"
sudo systemctl start docker.service || handle_error "Starting Docker service"

echo "----------------------------------------------------------------"
echo "Docker Setup Completed"
echo "----------------------------------------------------------------"
echo "Calling Samba Setup..."
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/breakdown-script/samba.sh | sudo bash
