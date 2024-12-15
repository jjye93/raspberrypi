#!/usr/bin/bash
echo " "
echo " "
echo " "
# System Upgrade
echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Argon One setup
if ! command -v curl &> /dev/null; then
    echo "curl not found. Installing curl..."
    sudo apt-get update
    sudo apt-get install curl -y
fi
echo "----------------------------------------------------------------"
echo "Commence Argon One Setup"
echo "----------------------------------------------------------------"
curl https://download.argon40.com/argon1.sh | bash 
if [ $? -eq 0 ]; then
    echo "----------------------------------------------------------------"
    echo "Argon One Setup Completed Successfully, Enter "argon-config" for configuration"
    echo "----------------------------------------------------------------"
else
    echo "----------------------------------------------------------------"
    echo "Error during Argon One Setup"
    echo "----------------------------------------------------------------"
    exit 1
fi
echo " "
echo " "
echo " "
# Docker setup
echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
echo "Updating package lists..."
sudo apt-get update
echo "Installing docker"
sudo apt-get install -y docker.io docker-compose
if ! command -v docker &> /dev/null; then
    echo "Docker installation failed. Exiting..."
    exit 1
fi
if ! command -v docker-compose &> /dev/null; then
    echo "Docker-Compose installation failed. Exiting..."
    exit 1
fi
echo "----------------------------------------------------------------"
echo "Adding user 'admin' to the Docker group..."
sudo usermod -aG docker admin
echo "----------------------------------------------------------------"
echo "Enabling Docker services to start on boot..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
echo "----------------------------------------------------------------"
echo "Starting Docker services..."
sudo systemctl start docker.service
sudo systemctl start containerd.service
echo "----------------------------------------------------------------"
echo "Verifying Docker service status..."
echo "----------------------------------------------------------------"
sudo systemctl status docker.service --no-pager
if sudo systemctl is-active --quiet docker; then
    echo "Docker is running successfully."
else
    echo "Docker is not running. Please check the logs."
    exit 1
fi
echo "----------------------------------------------------------------"
echo "Docker Setup Completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
# Samba setup
echo "----------------------------------------------------------------"
echo "Commence Samba Setup"
echo "----------------------------------------------------------------"
echo "Installing Samba..."
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install -y samba >/dev/null 2>&1
echo "Stopping Samba service..."
sudo systemctl stop samba
echo "Backup smb.conf"
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.1
sudo wget -O /etc/samba/smb.conf https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smb.conf
echo "Setting correct permissions for smb.conf..."
sudo chmod 644 /etc/samba/smb.conf
sudo chown root:root /etc/samba/smb.conf
echo "Starting Samba service..."
sudo systemctl start samba
echo "Setting Samba password for user 'admin'..."
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
send "admin\r"
expect eof
EOF
echo "Restarting Samba service..."
sudo systemctl restart samba
echo "----------------------------------------------------------------"
echo "Samba configuration is complete. SMB user 'admin' has been created with the password 'admin'."
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Commence Glances Setup"
echo "----------------------------------------------------------------"
sudo apt-get install glances -y >/dev/null 2>&1
sudo systemctl enable glances
sudo systemctl start glances
echo "----------------------------------------------------------------"
echo "Glances setting completed and host at http://localhost:61208"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Commence root-ssh account setting"
echo "----------------------------------------------------------------"
echo "Setting password for root..."
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
echo "Stopping ssh service..."
sudo systemctl stop ssh
echo "Backing up original sshd_config..."
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.1
echo "Downloading new smb.conf..."
sudo wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/sshd_config
echo "Setting correct permissions for sshd_config..."
sudo chmod 644 /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config
echo "Starting ssh service..."
sudo systemctl start ssh
echo "----------------------------------------------------------------"
echo "root-ssh setup completed"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "----------------------------------------------------------------"
echo "Commence docker-run"
echo "----------------------------------------------------------------"
echo "install portainer in docker"
sudo docker run -d --name portainer -p 9000:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/docker/portaimer:/data portainer/portainer-ce:latest
echo "----------------------------------------------------------------"
echo "portainer installed and running at http://pi.local:9000"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install radarr in docker"
sudo docker run -d --name radarr -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' -p '7878:7878' -v '/opt/docker/radarr:/config' -v '/dev/sda1:/media' -v '/media/downloads:/downloads' --restart 'unless-stoped' lscr.io/linuxserver/radarr:latest
echo "----------------------------------------------------------------"
echo "radarr installed and running at http://pi.local:7878"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install sonarr in docker"
sudo docker run -d --name sonarr -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' -p '8989:8989' -v '/opt/docker/sonarr:/config' -v '/dev/sda1/media' -v '/media/downloads:/downloads' --restart 'unless-stopped' lscr.io/linuxserver/sonarr:latest
echo "----------------------------------------------------------------"
echo "sonarr installed and running at http://pi.local:8989"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install prowlarr in docker"
sudo docker run -d --name prowlarr -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -p '9696:9696' -v '/opt/docker/prowlarr:/config' --restart 'unless-stopped' lscr.io/linuxserver/prowlarr:latest
echo "----------------------------------------------------------------"
echo "prowlarr installed and running at http://pi.local:9696"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo " install flaresolverr in docker"
sudo docker run -d --name flaresolverr -p '8191:8191' -e LOG_LEVEL=info --restart 'unless-stopped' ghcr.io/flaresolverr/flaresolverr:latest
echo "----------------------------------------------------------------"
echo "flaresolverr installed"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install aria2 in docker"
sudo docker run -d --name aria2 --restart 'unless-stopped' --log-opt max-size=1m -e PUID=1000 -e PGID=1000 -e UMASK_SET=022 -e 'TZ=Asia/Kuala_Lumpur' -e RPC_SECRET=qwer1234 -e RPC_PORT=6800 -p 6800:6800 -e LISTEN_PORT=6888 -p 6888:6888 -p 6888:6888/udp -v '/opt/docker/aria2:/config' -v '/media/dowmloads:/downloads' p3terx/aria2-pro:latest
sudo docker run -d --name ariang --log-opt max-size=1m --restart 'unless-stopped' -p '6880:6880' 
echo "----------------------------------------------------------------"
echo "aria2 installed and running with webui in http://pi.local:6880 with rpc_secret='qwer1234'."
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install transmission in docker"
sudo docker run -d --name transmission -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'USER=admin' -e 'PASS=admin' -e 'TZ=Asia/Kuala_Lumpur' -p '9091:9091' -p '51413:51413' -p '51413:51413/udp' -v '/opt/docker/transmission:/config' -v '/media/downloads:/downloads' --restart 'unless-stopped' lscr.io/linuxserver/transmission:latest
echo "----------------------------------------------------------------"
echo "transmission installed and running in http://pi.local:9091 with id admin and password admin"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install qbittorrent in docker"
sudo docker run -d --name qbittorrent -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' -e 'WEBUI_PORT=8080' -e 'TORRENTING_PORT=6881' -p '8080:8080' -p '6881:6881' -p '6881:6881/udp' -v '/opt/docker/qbittorrent:/config' -v '/media/downloads:/downloads' --restart 'unless-stopped' lscr.io/linuxserver/qbittorrent:latest
echo "----------------------------------------------------------------"
echo "qbittorent installed and running in http://pi.local:8080"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install alist in docker"
sudo docker run -d --name alist --restart always -v '/opt/docker/alist:/opt/alist/data' -v '/opt/docker/alist/data:/data' -p '5244:5244' -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' xhofe/alist:latest
echo "setting password for user admin"
sudo docker exec -it alist ./alist admin set admin
echo "----------------------------------------------------------------"
echo "alist installed and running in http://pi.local:5244 with id admin and password admin"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install plex media server in docker"
sudo docker run -d --name plex --restart 'unless-stopped' --net host -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' -e 'VERSION=docker' -v '/opt/docker/plex:/config' -v '/dev/sda1:/media/drive1' -v '/dev/sdb1:/media/drive2' -v '/media:/media/local' lscr.io/linuxserver/plex:latest
echo "----------------------------------------------------------------"
echo "plex media server installed and running in http://pi.local:32400/web"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install emby_media_server in docker"
sudo docker run -d --name emby --net host -e 'PUID=1000' -e 'PGID=1000' -e 'TZ=Asia/Kuala_Lumpur' -e 'UMASK=022' -v /opt/docker/emby:/config -v '/media:/media/local' -v '/dev/sda1:/media/drive1' -v '/dev/sdb1:/media/drive2' --restart unless-stopped lscr.io/linuxserver/emby:arm64v8-latest
echo "----------------------------------------------------------------"
echo "emby media server installed and running in http://pi.local:8096"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install watchtower in docker"
sudo docker run -d --name watchtower -v '/var/run/docker.sock:/var/run/docker.sock' containrrr/watchtower:latest
echo "----------------------------------------------------------------"
echo "watchtower installed"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "Docker Application install completed"
echo "portainer installed and running at http://pi.local:9000"
echo "radarr installed and running at http://pi.local:7878"
echo "sonarr installed and running at http://pi.local:8989"
echo "prowlarr installed and running at http://pi.local:9696"
echo "aria2 installed and running with webui at http://pi.local:6880 with rpc_secret='qwer1234'"
echo "transmission installed and running in http://pi.local:9091 with id admin and password admin"
echo "qbittorent installed and running in http://pi.local:8080"
echo "alist installed and running in http://pi.local:5244 with id admin and password admin"
echo "plex media server installed and running in http://pi.local:32400/web"
echo "emby media server installed and running in http://pi.local:8096"
echo "----------------------------------------------------------------"
echo " "
echo " "
echo " "
echo "Installation completed"
echo "----------------------------------------------------------------"
echo "The system needs to reboot to complete the setup."
echo "----------------------------------------------------------------"
read -p "Do you want to reboot now? (y/n): " response

# Check if the response is 'y' or 'Y'
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Rebooting the system..."
    sudo reboot
else
    echo "Reboot canceled. You can reboot later manually."
fi
