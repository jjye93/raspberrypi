#!/usr/bin/bash
echo "transmission"
sudo apt install transmission-daemon -y
sudo systemctl stop transmission-daemon
sudo mkdir -p /media/{local,torrent}
sudo chown -R $USER:$USER /media/local
sudo chown -R $USER:$USER /media/torrent
sudo mv /etc/transmission-daemon/settings.json /etc/transmission-daemon/settings.json.backup
sudo wget -O /etc/transmission-daemon/settings.json https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/settings.json
sudo mv /etc/init.d/transmission-daemon /etc/init.d/transmissiion-daemon.backup
sudo wget -O /etc/init.d/transmission-daemon https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/transmission-daemon
sudo mv /etc/systemd/system/multi-user.target.wants/transmission-daemon.servive /etc/systemd/system/multi-user.target.wants/transmission-daemon.servive.backup
sudo wget -O /etc/systemd/system/multi-user.target.wants/transmission-daemon.servive https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/transmission-daemon.service
sudo systemctl daemon-reload
sudo chown -R $USER:$USER /etc/transmission-daemon
sudo mkdir -p /home/$USER/.config/transmission-daemon
sudo ln -s /etc/transmission-daemon/settings.json /home/$USER/.config/transmission-daemon/
sudo chown -R $USER:$USER /home/$USER/.config/transmission-daemon/
sudo systemctl start transmission-daemon
