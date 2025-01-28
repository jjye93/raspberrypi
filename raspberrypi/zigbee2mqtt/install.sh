#!/usr/bin/bash
echo "zigbee2mqtt"
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs git make g++ gcc libsystemd-dev
sudo npm install -g pnpm
sudo mkdir /etc/zigbee2mqtt
sudo chown -R ${USER}: /etc/zigbee2mqtt
git clone --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /etc/zigbee2mqtt
cd /etc/zigbee2mqtt
pnpm i --frozen-lockfile
pnpm run build
cp /etc/zigbee2mqtt/data/configuration.example.yaml /etc/zigbee2mqtt/data/configuration.yaml


