#!/usr/bin/bash

echo "Docker Compose Script"
echo "Please select an application to install"

pause_and_return() {
    echo "Do you want to continue?"
    select next_step in "Yes" "No"; do
        case $REPLY in
            1) break ;;
            2) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
    done
}

install_docker() {
    echo "Installing Docker..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/docker/install.sh)"
    echo "Completed"
    pause_and_return
}

flaresolverr() {
    echo "Install Flaresolverr"
    sudo mkdir -p ~/Docker/flaresolverr
    curl -O ~/Docker/flaresolverr/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/flaresolverr/compose.yml
    sudo docker compose -f ~/Docker/flaresolverr/compose.yml up -d
    echo "completed"
    pause_and_return
}

photoprism() {
    echo "Install Photoprism"
    sudo mkdir -p ~/Docker/photoprism
    curl -O ~/Docker/photoprism/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/photoprism/compose.yml
    sudo docker compose -f ~/Docker/photoprism/compose.yml up -d
    echo "completed"
    pause_and_return
}

portainer() {
    echo "Install portainer"
    sudo mkdir -p ~/Docker/portainer
    curl -O ~/Docker/portainer/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/portainer/compose.yml
    sudo docker compose -f ~/Docker/portainer/compose.yml up -d
    echo "completed"
    pause_and_return

}

qbittorrent() {
    echo "Install qbittorrent"
    sudo mkdir -p ~/Docker/qbittorrent
    curl -O ~/Docker/qbittorrent/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/qbittorrent/compose.yml
    sudo docker compose -f ~/Docker/qbittorrent/compose.yml up -d
    echo "completed"
    pause_and_return    
}

alist() {
    echo "Install alist"
    sudo mkdir -p ~/Docker/alist
    curl -O ~/Docker/alist/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/alist/compose.yml
    sudo docker compose -f ~/Docker/alist/compose.yml up -d
    echo "completed"
    pause_and_return    
}

homeassistant() {
    echo "Install homeassistant"
    sudo mkdir -p ~/Docker/homeassistant
    curl -O ~/Docker/homeassistant/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/homeassistant/compose.yml
    sudo docker compose -f ~/Docker/homeassistant/compose.yml up -d
    echo "completed"
    pause_and_return    
}

autobangumi() {
    echo "Install autobangumi"
    sudo mkdir -p ~/Docker/autobangumi
    curl -O ~/Docker/autobangumi/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/autobangumi/compose.yml
    sudo docker compose -f ~/Docker/autobangumi/compose.yml up -d
    echo "completed"
    pause_and_return    
}

PS3="Select application to run: "
options=("Docker" "FlareSolverr" "PhotoPrism" "Portainer" "qBittorrent" "alist" "Home Assistant" "AutoBangumi" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) install_docker ;;
            2) flaresolverr ;; 
            3) photoprism ;;
            4) portainer ;;
            5) qbittorrent ;;
            6) alist ;;
            7) homeassistant ;;
            8) autobangumi ;;
            9) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break
    done
done
