#!/usr/bin/bash
sudo apt-get install aria2 -y
sudo mkdir -p /etc/aria2-webui/aria2
sudo git clone https://github.com/ziahamza/webui-aria2.git /etc/aria2-webui && cd /etc/aria2-webui
cat << EOF | sudo tee /etc/aria2-webui/aria2/aria2.conf > /dev/null
dir=/home/admin/Downloads
max-concurrent-downloads=6
continue=true
quiet=true
allow-overwrite=true
allow-piece-length-change=true
disk-cache=64M
file-allocation=falloc
no-file-allocation-limit=8M
enable-rpc=true
pause=true
rpc-allow-origin-all=true
rpc-listen-all=true
rpc-listen-port=6800
rpc-secret=qwer1234
max-connection-per-server=16
min-split-size=8M
split=32
max-overall-upload-limit=256K
max-upload-limit=64K
seed-ratio=0.1
seed-time=0
EOF

cat << EOF | sudo tee /etc/systemd/system/aria2.service > /dev/null
[Unit]
Description=Aria2
Requires=network.target
After=dhcpcd.service

[Service]
ExecStart=/usr/bin/aria2c --conf-path=/etc/aria2-webui/aria2/aria2.conf

[Install]
WantedBy=default.target
EOF

sudo systemctl start aria2
sudo systemctl enable aria2

sudo apt-get install npm -y
sudo npm install -g pm2
pm2 start node-server.js
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u admin --hp /home/admin
pm2 save
