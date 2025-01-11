#!/usr/bin/bash
echo "photoprism"
sudo mkdir -p /etc/photoprism
sudo apt install wget -y
sudo wget -O /etc/photoprism/docker-compose.yml https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/docker-compose/photoprism/docker-compose.yml
cd /etc/photoprism
sudo docker-compose up -d
cd
echo "complete and host at port:2342"
