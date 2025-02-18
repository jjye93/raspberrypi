#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "qbittorrent"
echo "----------------------------------------------------------------"
sudo apt install qbittorrent-nox -y
cat << EOF | sudo tee /etc/systemd/system/qbittorrent.service > /dev/null
[Unit]
Description=qBittorrent
After=network.target

[Service]
Type=forking
UMask=022
ExecStart=/usr/bin/qbittorrent-nox -d --webui-port=8081
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl start qbittorrent
sudo systemctl enable qbittorrent
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/transmission.sh | sudo bash
