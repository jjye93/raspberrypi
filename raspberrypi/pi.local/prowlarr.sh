#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Prowlarr"
echo "----------------------------------------------------------------"
sudo apt install curl sqlite3 -y
wget --content-disposition 'http://prowlarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=arm64'
tar -xvzf Prowlarr*.linux*.tar.gz
sudo mv Prowlarr/ /etc
sudo chown $USER:$USER -R /etc/Prowlarr
cat << EOF | sudo tee /etc/systemd/system/prowlarr.service > /dev/null
[Unit]
Description=Prowlarr Daemon
After=syslog.target network.target

[Service]
Type=simple
ExecStart=/etc/Prowlarr/Prowlarr -nobrowser -data=/var/lib/prowlarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl -q daemon-reload
sudo systemctl enable --now -q prowlarr
rm Prowlarr*.linux*.tar.gz
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/qbittorrent.sh | sudo bash
