#!/usr/bin/bash

echo "zigbee2mqtt"
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs git make g++ gcc libsystemd-dev
sudo npm install -g pnpm
sudo mkdir /etc/zigbee2mqtt
git clone --depth 1 https://github.com/Koenkk/zigbee2mqtt.git /etc/zigbee2mqtt
sudo chown -R admin: /etc/zigbee2mqtt && sudo chmod -R 777 /etc/zigbee2mqtt && cd /etc/zigbee2mqtt
pnpm i --frozen-lockfile
pnpm run build

cat << EOF | sudo tee /etc/zigbee2mqtt/data/configuration.yaml > /dev/null
version: 4
homeassistant:
    enabled: false
frontend:
    enabled: true
    port: 9699
mqtt:
    base_topic: zigbee2mqtt
    server: 'mqtt://localhost:1883'
    user: admin
    password: qwer1234
serial:
    port: /dev/ttyUSB0
    adapter: ember
availability:
    enable: true
advance:
    transmit_power: 20
    baudrate: 115200
    network_key: GENERATE
    pan_id: GENERATE
    ext_pan_id: GENERATE
EOF

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
