#！/usr/bin/bash

echo "Docker Compose Script"
echo "Please select application for docker compose to install"

pause_and_return() {
    echo "Do you want to continue?"
    select next_step in "Yes" "No"; do
        case $REPLY in
            1) break ;;  # Just break the select, returning to the main loop
            2) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
    done
}

docker() {
    echo "Installing Docker"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/docker/install.sh)"
    echo "Completed"
    pause_and_return
}

flaresolverr() {
    echo "Install Flaresolverr"
    sudo mkdir -p ~/Docker/flaresolverr
    sudo wget -O ~/Docker/flaresolverr/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/flaresolverr/compose.yml
    cd ~/Docker/flaresolverr/
    docker compose up -d
    echo "completed"
    pause_and_return
}

photoprism() {
    echo "Install Photoprism"
    sudo mkdir -p ~/Docker/photoprism
    sudo wget -O ~/Docker/photoprism/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/photoprism/compose.yml
    cd ~/Docker/photoprism/
    docker compose up -d
    echo "completed"
    pause_and_return
}

portainer() {
    echo "Install portainer"
    sudo mkdir -p ~/Docker/portainer
    sudo wget -O ~/Docker/portainer/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/portainer/compose.yml
    cd ~/Docker/portainer/
    docker compose up -d
    echo "completed"
    pause_and_return

}

qbittorrent() {
    echo "Install qbittorrent"
    sudo mkdir -p ~/Docker/qbittorrent
    sudo wget -O ~/Docker/qbittorrent/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/qbittorrent/compose.yml
    cd ~/Docker/qbittorrent/
    docker compose up -d
    echo "completed"
    pause_and_return    
}

alist() {
    echo "Install alist"
    sudo mkdir -p ~/Docker/alist
    sudo wget -O ~/Docker/alist/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/alist/compose.yml
    cd ~/Docker/alist/
    docker compose up -d
    echo "completed"
    pause_and_return    
}

homeassistant() {
    echo "Install homeassistant"
    sudo mkdir -p ~/Docker/homeassistant
    sudo wget -O ~/Docker/homeassistant/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/homeassistant/compose.yml
    cd ~/Docker/homeassistant/
    docker compose up -d
    echo "completed"
    pause_and_return    
}

PS3="Select application to run: "
options=("Docker" "FlareSolverr" "PhotoPrism" "Portainer" "qBittorrent" "alist" "homeassistant" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) docker ;;
            2) flaresolverr ;;
            3) photoprism ;;
            4) portainer ;;
            5) qbittorrent ;;
            6) alist ;;
            7) homeassistant ;;
            8) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break
    done
done
