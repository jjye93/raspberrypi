#!/usr/bin/bash
echo "update"
sudo apt update && sudo apt full-upgrade -y
echo "update zigbee2mqtt"
sudo ./etc/zigbee2mqtt/update.sh -y
echo "update docker's server"
cd
docker compose down
docker compose up -d
echo "update scrypted"
cd .scrypted
docker compose down 
docker compose up -d
echo "completed"
