#!/usr/bin/bash
mkdir -p ~/Docker/portainer
wget -O ~/Docker/portainer/compose.yml https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/portainer/docker-compose.yml
chmod +x ~/Docker/portainer/compose.yml
cd ~/Docker/portainer
sudo docker compose up -d
echo "Complete"
