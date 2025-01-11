#!/usr/bin/bash
echo "aria2"
sudo apt install aria2 -y
sudo apt install git -y
sudo mkdir /etc/aria2-webui
sudo git clone https://github.com/ziahamza/webui-aria2.git /etc/aria2-webui
sudo killall aria2c
sudo mkdir /etc/aria2 -p
sudo wget -O /etc/aria2/aria.conf https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/aria2.conf
sudo chmod 755 /etc/aria2/aria.conf
sudo wget -O /etc/systemd/system/aria2.service https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/aria2.service
sudo chmod 755 /etc/systemd/system/aria2.service
sudo systemctl enable aria2
sudo systemctl start aria2
sudo reboot
echo "complete"
