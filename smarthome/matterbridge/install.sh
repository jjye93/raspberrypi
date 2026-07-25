#!/usr/bin/bash
npm install -g matterbridge --omit=dev
mkdir /etc/matterbridge/Matterbridge
mkdir /etc/matterbridge/.matterbridge
sudo chmod -R $USER:$USER /etc/matterbridge
cat << EOF | sudo tee /etc/systemd/system/matterbridge.service > /dev/null
[Unit]
Description=matterbridge
After=network-online.target

[Service]
Type=simple
ExecStart=matterbridge -service
WorkingDirectory=/etc/matterbridge/Matterbridge
StandardOutput=inherit
StandardError=inherit
Restart=always
RestartSec=10s
TimeoutStopSec=30s
User=$USER
Group=$USER

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl start matterbridge
sudo systemctl enable matterbridge
