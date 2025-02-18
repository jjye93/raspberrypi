#!/usr/bin/bash
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
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/prowlarr.sh | sudo bash
