#!/usr/bin/bash
set -e

echo "----------------------------------------------------------------"
echo "Commence docker-run"
echo "----------------------------------------------------------------"
echo "install portainer in docker"
sudo docker run -d \
    --name portainer \
    -p 9000:9000 \
    --restart always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /opt/docker/portaimer:/data \
    portainer/portainer-ce:latest
echo "----------------------------------------------------------------"
echo "portainer installed and running at http://pi.local:9000"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install radarr in docker"
sudo docker run -d \
    --name radarr \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'UMASK=022' \
    -p '7878:7878' \
    -v '/opt/docker/radarr:/config' \
    -v '/media/downloads:/downloads' \
    --restart 'unless-stopped' \
    lscr.io/linuxserver/radarr:latest
echo "----------------------------------------------------------------"
echo "radarr installed and running at http://pi.local:7878"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install sonarr in docker"
sudo docker run -d \
    --name sonarr \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'UMASK=022' \
    -p '8989:8989' \
    -v '/opt/docker/sonarr:/config' \
    -v '/media/downloads:/downloads' \
    --restart 'unless-stopped' \
    lscr.io/linuxserver/sonarr:latest
echo "----------------------------------------------------------------"
echo "sonarr installed and running at http://pi.local:8989"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install prowlarr in docker"
sudo docker run -d \
    --name prowlarr \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -p '9696:9696' \
    -v '/opt/docker/prowlarr:/config' \
    --restart 'unless-stopped' \
    lscr.io/linuxserver/prowlarr:latest
echo "----------------------------------------------------------------"
echo "prowlarr installed and running at http://pi.local:9696"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo " install flaresolverr in docker"
sudo docker run -d \
    --name flaresolverr \
    -p '8191:8191' \
    -e LOG_LEVEL=info \
    --restart 'unless-stopped' \
    ghcr.io/flaresolverr/flaresolverr:latest
echo "----------------------------------------------------------------"
echo "flaresolverr installed"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install aria2 in docker"
sudo docker run -d \
    --name aria2 \
    --restart 'unless-stopped' \
    --log-opt max-size=1m \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK_SET=022 \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e RPC_SECRET=qwer1234 \
    -e RPC_PORT=6800 \
    -p 6800:6800 \
    -e LISTEN_PORT=6888 \
    -p 6888:6888 \
    -p 6888:6888/udp \
    -v '/opt/docker/aria2:/config' \
    -v '/media/downloads:/downloads' \
    p3terx/aria2-pro:latest

sudo docker run -d \
    --name ariang \
    --log-opt max-size=1m \
    --restart 'unless-stopped' \
    -p '6880:6880' \
    --net host \
    p3terx/ariang:latest
echo "----------------------------------------------------------------"
echo "aria2 installed and running with webui in http://pi.local:6880 with rpc_secret='qwer1234'."
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install transmission in docker"
sudo docker run -d \
    --name transmission \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'USER=admin' \
    -e 'PASS=admin' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -p '9091:9091' \
    -p '51413:51413' \
    -p '51413:51413/udp' \
    -v '/opt/docker/transmission:/config' \
    -v '/media/downloads:/downloads' \
    --restart 'unless-stopped' \
    lscr.io/linuxserver/transmission:latest
echo "----------------------------------------------------------------"
echo "transmission installed and running in http://pi.local:9091 with id admin and password admin"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install qbittorrent in docker"
sudo docker run -d \
    --name qbittorrent \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'UMASK=022' \
    -e 'WEBUI_PORT=8080' \
    -e 'TORRENTING_PORT=6881' \
    -p '8080:8080' \
    -p '6881:6881' \
    -p '6881:6881/udp' \
    -v '/opt/docker/qbittorrent:/config' \
    -v '/media/downloads:/downloads' \
    --restart 'unless-stopped' \
    lscr.io/linuxserver/qbittorrent:latest
echo "----------------------------------------------------------------"
echo "qbittorent installed and running in http://pi.local:8080"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install alist in docker"
sudo docker run -d \
    --name alist \
    --restart always \
    -v '/opt/docker/alist:/opt/alist/data' \
    -v '/opt/docker/alist/data:/data' \
    -p '5244:5244' \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'UMASK=022' \
    xhofe/alist:latest
echo "setting password for user admin"
sudo docker exec -it alist ./alist admin set admin
echo "----------------------------------------------------------------"
echo "alist installed and running in http://pi.local:5244 with id admin and password admin"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install plex media server in docker"
sudo docker run -d \
    --name plex \
    --restart 'unless-stopped' \
    --net host \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'UMASK=022' \
    -e 'VERSION=docker' \
    -v '/opt/docker/plex:/config' \
    -v '/media:/media/local' \
    lscr.io/linuxserver/plex:latest
echo "----------------------------------------------------------------"
echo "plex media server installed and running in http://pi.local:32400/web"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install emby_media_server in docker"
sudo docker run -d \
    --name emby \
    --net host \
    -e 'PUID=1000' \
    -e 'PGID=1000' \
    -e 'TZ=Asia/Kuala_Lumpur' \
    -e 'UMASK=022' \
    -v /opt/docker/emby:/config \
    -v '/media:/media/local' \
    --restart unless-stopped \
    lscr.io/linuxserver/emby:arm64v8-latest
echo "----------------------------------------------------------------"
echo "emby media server installed and running in http://pi.local:8096"
echo "----------------------------------------------------------------"
echo "----------------------------------------------------------------"
echo "install watchtower in docker"
sudo docker run -d \
    --name watchtower \
    -v '/var/run/docker.sock:/var/run/docker.sock' \
    containrrr/watchtower:latest
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

echo "Installation Completed"
echo "----------------------------------------------------------------"
echo "Press any key to reboot the system..."
echo "----------------------------------------------------------------"
# Wait for user input
read -n 1 -s -r
# Reboot the system
echo "Rebooting the system..."
sudo reboot
