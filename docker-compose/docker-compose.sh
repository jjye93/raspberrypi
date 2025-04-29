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
    sudo mkdir -p /etc/flaresolverr
    sudo wget -O /etc/flaresolverr/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/flaresolverr/compose.yml
    sudo docker compose -f /etc/flaresolverr/compose.yml up -d
    echo "completed"
    pause_and_return
}

photoprism() {
    echo "Install Photoprism"
    sudo mkdir -p /etc/photoprism
    sudo wget -O /etc/photoprism/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/photoprism/compose.yml
    sudo docker compose -f /etc/photoprism/compose.yml up -d
    echo "completed"
    pause_and_return
}

portainer() {
    echo "Install portainer"
    sudo mkdir -p /etc/portainer
    sudo wget -O /etc/portainer/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/portainer/compose.yml
    sudo docker compose -f /etc/portainer/compose.yml up -d
    echo "completed"
    pause_and_return

}

homeassistant() {
    echo "Install homeassistant"
    sudo mkdir -p /etc/homeassistant
    sudo wget -O /etc/homeassistant/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/homeassistant/compose.yml
    sudo docker compose -f /etc/homeassistant/compose.yml up -d
    echo "completed"
    pause_and_return    
}

ani-rss() {
    echo "Install ani-rss"
    sudo mkdir -p /etc/ani-rss
    sudo wget -O /etc/ani-rss/compose.yml https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/Ani-rss/compose.yml
    sudo docker compose -f /etc/ani-rss/compose.yml up -d
    echo "completed"
    pause_and_return
}

immich() {
    echo "Install immich"
    sudo mkdir -p /etc/immich
    sudo wget -O /etc/immich/compose.yml https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/immich/compose.yml
    sudo wget -O /etc/immich/.env https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/immich/.env
    sudo docker compose -f /etc/immich/compose.yml
    echo "completed"
    pause_and-return
}

PS3="Select application to run: "
options=("Docker" "FlareSolverr" "PhotoPrism" "Portainer" "Home Assistant" "Ani-rss" "immich" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) install_docker ;;
            2) flaresolverr ;;
            3) photoprism ;;
            4) portainer ;;
            5) homeassistant ;;
            6) ani-rss ;;
            7) immich ;;
            8) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break
    done
done
