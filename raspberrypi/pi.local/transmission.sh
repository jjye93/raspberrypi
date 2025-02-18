#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Transmission"
echo "----------------------------------------------------------------"
sudo apt install transmission-daemon -y
sudo systemctl stop transmission-daemon
sudo mkdir -p /home/admin/.transmission/process
sudo chown -R admin:admin /home/admin/.transmission/process
sudo usermod -a -G debian-transmission admin
chgrp debian-transmission /home/admin/.transmission/process
chgrp debian-transmission /home/admin/Downloads
chmod 770 /home/admin/.transmission/process
chmod 770 /home/admin/Downloads
sudo mv /etc/transmission-daemon/settings.json /etc/transmission-daemon/settings.json.backup
sudo wget -O /etc/transmission-daemon/settings.json https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/settings.json
sudo chmod 777 /etc/transmission-daemon/settings.json && sudo chown root:root /etc/transmission-daemon/settings.json
sudo systemctl start transmission-daemon
sudo systemctl enable transmission-daemon
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
sleep 5s
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/aria2.sh | sudo bash
