#/usr/bin/bash

sudo mkdir -p /etc/immich
sudo chown -R admin:admin /etc/immich
sudo chmod -R 755 /etc/immich
wget -O /etc/immich/compose.yml https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/immich/compose.yml
wget -O /etc/immich/.env https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/immich/.env
