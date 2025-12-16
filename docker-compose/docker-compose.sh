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
    bash -c "$(curl -fsSL https://get.docker.com)"
    echo "Completed"
    pause_and_return
}

flaresolverr() {
    echo "Install Flaresolverr"
    sudo mkdir -p ~/Applications/flaresolverr
    sudo git clone -O ~/Applications/flaresolverr https://github.com/FlareSolverr/FlareSolverr.git
    sudo docker compose -f ~/Applications/flaresolverr/docker-compose.yml up -d
    echo "completed"
    pause_and_return
}

photoprism() {
    echo "Install Photoprism"
    sudo mkdir -p ~/Applications/photoprism
    sudo wget -O ~/Applications/photoprism/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/photoprism/compose.yml
    sudo docker compose -f ~/Applications/photoprism/compose.yml up -d
    echo "completed"
    pause_and_return
}

portainer() {
    echo "Install portainer"
    sudo mkdir -p ~/Applications/portainer
    sudo wget -O ~/Applications/portainer/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/portainer/compose.yml
    sudo docker compose -f ~/Applications/portainer/compose.yml up -d
    echo "completed"
    pause_and_return

}

homeassistant() {
    echo "Install homeassistant"
    sudo mkdir -p ~/Applications/homeassistant
    sudo wget -O ~/Applications/homeassistant/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/homeassistant/compose.yml
    sudo docker compose -f ~/Applications/homeassistant/compose.yml up -d
    echo "completed"
    pause_and_return    
}

ani-rss() {
    echo "Install ani-rss"
    sudo mkdir -p ~/Applications/ani-rss
    sudo wget -O ~/Applications/ani-rss/compose.yml https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/Ani-rss/compose.yml
    sudo docker compose -f ~/Applications/ani-rss/compose.yml up -d
    echo "completed"
    pause_and_return
}

immich() {
    echo "Install immich"
    sudo mkdir -p ~/Applications/immich
    sudo wget -O ~/Applications/immich/compose.yml https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/immich/compose.yml
    sudo wget -O ~/Applications/immich/.env https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/immich/.env
    sudo docker compose -f ~/Applications/immich/compose.yml up -d
    echo "completed"
    pause_and-return
}

kvideo() {
    echo "Install Kvideo"
    sudo mkdir -p ~/Applications/kvideo
    sudo wget -O ~/Applications/kvideo/compose.yml https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/kvideo/compose.yml
    sudo docker compose -f ~/Applications/kvideo/compose.yml up -d
    echo "completed"
    pause_and-return
}

PS3="Select application to run: "
options=("Docker" "FlareSolverr" "PhotoPrism" "Portainer" "Home Assistant" "Ani-rss" "immich" "kvideo" "Exit")

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
            8) kvideo ;;
            9) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break
    done
done
