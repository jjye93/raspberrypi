#!/usr/bin/bash
echo "transmission"
sudo apt install transmission-daemon -y
sudo systemctl stop transmission-daemon
sudo mkdir -p /media/{local,torrent}
sudo chown -R $USER:$USER /media/local
sudo chown -R $USER:$USER /media/torrent
