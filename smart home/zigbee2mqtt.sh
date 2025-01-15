#!/usr/bin/bash
echo "zigbee2mqtt"
sudo apt-get update && sudo apt-get full-upgrade && sudo apt-get install curl -y
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs git make g++ gcc libsystemd-dev
sudo mkdir -p /opt/zigbee2mqtt
sudo chown -R aj: /opt/zigbee2mqtt
git clone --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
cd /opt/zigbee2mqtt
npm ci
npm run build
sudo wget -o /opt/zigbee2mqtt/configuration.yaml https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smart%20home/zigbee2mqtt/configuration.yaml
sudo chmod +x /opt/zigbee2mqtt/configuration.yaml
cd /opt/zigbee2mqtt
npm start
sudo wget -o /etc/systemd/system/zigbee2mqtt.service https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smart%20home/zigbee2mqtt/zigbee2mqtt.service
sudo chmod +x /etc/systemd/system/zigbee2mqtt.service
sudo systemctl enable zigbee2mqtt.service
sudo systemctl start zigbee2mqtt.service
systemctl status zigbee2mqtt.service
echo "complete"
