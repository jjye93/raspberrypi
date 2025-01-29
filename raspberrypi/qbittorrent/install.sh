#!/usr/bin/bash
echo "qbittorrent"
sudo apt-get update && sudo apt-get full-upgrade -y
sudo apt-get install qbittorrent-nox -y
sudo useradd -r -m qbittorrent
sudo usermod -a -G qbittorrent admin
sudo wget -O /etc/systemd/system/qbittorrent.service https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/qbittorrent/qbittorrent.service
sudo chmod 777 /etc/systemd/system/qbittorrent.service
sudo systemctl start qbittorrent.service
sudo systemctl enable qbittorrent.service
echo "completed"
