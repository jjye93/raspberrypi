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
sudo wget -O /etc/zigbee2mqtt/data/configuration.yaml https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smart%20home/zigbee2mqtt/configuration.yaml
cat << EOF | sudo tee /etc/systemd/system/zigbee2mqtt.service > /dev/null
[Unit]
Description=zigbee2mqtt
After=network.target

[Service]
Environment=NODE_ENV=production
Type=notify
ExecStart=/usr/bin/node index.js
WorkingDirectory=/etc/zigbee2mqtt
StandardOutput=inherit
StandardError=inherit
WatchdogSec=10s
Restart=always
RestartSec=10s
User=admin

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl start zigbee2mqtt
sudo systemctl enable zigbee2mqtt
echo "completed"
