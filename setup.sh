#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Update & Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install ca-certificate bash curl sudo git -y
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "Commence Argon Neo Setup"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argonneo.sh | bash 
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
curl https://get.docker.com |sudo bash
sudo groupadd docker
sudo usermod -aG docker admin
sudo chown admin:admin /home/admin/.docker -R
sudo chmod g+rwx /home/admin/.docker -R
sudo systemctl start docker.service
sudo systemctl start containerd.service
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "Samba"
echo "----------------------------------------------------------------"
sudo apt install samba -y
sudo systemctl stop samba
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.1
sudo wget -O /etc/samba/smb.conf https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smb.conf
sudo chmod 644 /etc/samba/smb.conf
sudo chown root:root /etc/samba/smb.conf
sudo systemctl start samba
if ! command -v expect &> /dev/null
then
    echo "Expect is not installed, installing..."
    sudo apt-get install -y expect
fi

expect <<EOF
spawn sudo smbpasswd -a admin
expect "New SMB password:"
send "admin\r"
expect "Retype new SMB password:"
send "qwer1234\r"
expect eof
EOF
sudo systemctl restart samba
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "SSH"
echo "----------------------------------------------------------------"
if ! command -v expect &> /dev/null
then
    echo "Expect is not installed, installing..."
    sudo apt-get install -y expect
fi

expect <<EOF
spawn sudo passwd root
expect "New password:"
send "admin\r"
expect "Retype new password:"
send "admin\r"
expect eof
EOF
sudo systemctl stop ssh
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.1
sudo wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/sshd_config
sudo chmod 644 /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config
sudo systemctl start ssh
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "Plex"
echo "----------------------------------------------------------------"
sudo apt install apt-transport-https -y
curl https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | sudo tee /usr/share/keyrings/plex-archive-keyring.gpg >/dev/null
echo deb [signed-by=/usr/share/keyrings/plex-archive-keyring.gpg] https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt update
sudo apt install plexmediaserver -y
echo "----------------------------------------------------------------"
echo "Completed"
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
echo "qbittorrent"
echo "----------------------------------------------------------------"
sudo apt install qbittorrent-nox -y
sudo mv /etc/systemd/system/qbittorrent.service /etc/systemd/system/qbittorrent.service.backup
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
echo "Transmission"
echo "----------------------------------------------------------------"
sudo apt install transmission-daemon -y
sudo systemctl stop transmission-daemon
sudo mkdir -p /home/admin/.transmission/process
sudo chown -R admin:admin /home/admin/.transmission/process
sudo usermod -a -G debian-transmission admin
chgrp debian-transmission /home/admin/.transmission/progress
chgrp debian-transmission /home/admin/Downloads
chmod 770 /home/admin/.transmission/progress
chmod 770 /home/admin/Downloads
sudo mv /etc/transmission-daemon/settings.json /etc/transmission-daemon/settings.json.backup
sudo wget -O /etc/transmission-daemon/settings.json https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/settings.json
sudo chmod 777 /etc/transmission-daemon/settings.json && sudo chown root:root /etc/transmission-daemon/settings.json
sudo service transmission-daemon reload
sudo systemctl start transmission-daemon
sudo ststemctl enable transmission-daemon
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "aria2"
echo "----------------------------------------------------------------"
sudo apt-get install aria2 -y
sudo mkdir /etc/aria2
cat << EOF | sudo tee /etc/aria2/aria2.conf > /dev/null
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
cat << EOF | sudo tee /etc/systemd/system/aria2.services > /dev/null
[Unit]
Description=Aria2
Requires=network.target
After=dhcpcd.service

[Service]
ExecStart=/usr/bin/aria2c --conf-path=/etc/aria2/aria2.conf

[Install]
WantedBy=default.target
EOF
sudo systemctl start aria2
sudo systemctl enable aria2
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "aria2-webui"
echo "----------------------------------------------------------------"
sudo mkdir -p /etc/aria2-webui
sudo git clone https://github.com/ziahamza/webui-aria2.git /etc/aria2-webui && cd /etc/aria2-webui
sudo apt-get install npm -y
sudo npm install -g pm2
pm2 start node-server.js
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u admin --hp /home/admin
pm2 save
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "Portainer"
echo "----------------------------------------------------------------"
sudo docker run -d --name portainer -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /etc/portainer:/data portainer/portainer-ce:latest
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "Flaresolverr"
echo "----------------------------------------------------------------"
sudo docker run -d --name flaresolverr -p '8191:8191' -e LOG_LEVEL=info --restart 'unless-stopped' ghcr.io/flaresolverr/flaresolverr:latest
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "Alist"
echo "----------------------------------------------------------------"
sudo docker run -d --name alist --restart always -v '/etc/alist:/opt/alist/data' -v '/etc/alist/data:/data' -p '5244:5244' -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' xhofe/alist:latest
sudo docker exec -it alist ./alist admin set qwer1234
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
echo "portainer; http://pi.local:9000"
echo "prowlarr; http://pi.local:9696"
echo "aria2; http://pi.local:8888; rpc_secret=qwer1234"
echo "transmission; http://pi.local:9091 with id admin and password qwer1234"
echo "qbittorent; http://pi.local:8081"
echo "alist; http://pi.local:5244 with id admin and password qwer1234"
echo "plex media server; http://pi.local:32400/web"
echo "----------------------------------------------------------------"
echo "please perform a reboot"
echo "----------------------------------------------------------------"
