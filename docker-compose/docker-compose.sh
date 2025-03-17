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

install_service() {
    local service_name="$1"
    local compose_url="$2"
    local service_path="~/Docker/$service_name"

    echo "Installing $service_name..."
    sudo mkdir -p "$service_path"
    curl -o "$service_path/compose.yml" "$compose_url"

    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Please install it first."
        exit 1
    fi

    sudo docker compose -f "$service_path/compose.yml" up -d
    echo "Completed"
    pause_and_return
}

PS3="Select application to run: "
options=("Docker" "FlareSolverr" "PhotoPrism" "Portainer" "qBittorrent" "alist" "Home Assistant" "AutoBangumi" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) install_docker ;;
            2) install_service "flaresolverr" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/flaresolverr/compose.yml" ;;
            3) install_service "photoprism" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/photoprism/compose.yml" ;;
            4) install_service "portainer" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/portainer/compose.yml" ;;
            5) install_service "qbittorrent" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/qbittorrent/compose.yml" ;;
            6) install_service "alist" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/alist/compose.yml" ;;
            7) install_service "homeassistant" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/homeassistant/compose.yml" ;;
            8) install_service "autobangumi" "https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/autobangumi/compose.yml" ;;
            9) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break
    done
done
