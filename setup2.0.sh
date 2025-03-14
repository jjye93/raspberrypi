#!/usr/bin/bash

echo "Raspberry Pi 5 installation script"
echo "Please select for installation"

pause_and_return() {
    echo "Do you want to continue? "
    select next_step in "Yes" "No"; do
        case $REPLY in
            1) return ;;
            2) echo "Exiting..."; exit 0;;
            *) echo "Invalid..."; exit 0;;
        esac
    done
}

Update&Upgrade() {
    echo "Running Update & Upgrade"
    sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y
    echo "Completed"
    pause_and_return
}

Docker() {
    echo "Install Docker"
    bash -c "$(curl -fsSL https://get.docker.com)"
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    echo "Completed"
    pause_and_return
}

Samba() {
    echo "Install and Configure Samba"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/samba/install.sh)"
    echo "set username as "admin" and password as "qwer1234" "
    echo "Install Completed"
    pause_and_return
}

SSH() {
    echo "configuring SSH for root user"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/ssh/install.sh)"
    echo "set username as "root" and password as "qwer1234" "
    echo "Completed"
    pause_and_return
}

Plex() {
    echo "Installing Plex"
    bash -c "curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/plex/install.sh)"
    echo "Completed"
    pause_and_return
}

Prowlarr() {
    echo "Installing Prowlarr"
    bash -c "curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/prowlarr/install.sh)"
    echo "Completed"
    pause_and_return
}

qbittorrent() {
    echo "Installing qbittorrent"
    bash -c "curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/qbittorrent/install.sh"
    echo "Completed"
    pause_and_return
}

transmission() {
    echo "Installing transmission"
    bash -c "curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/install2.sh"
    echo "Completed"
    pause_and_return
}

aria2() {
    echo "Installing aria2-webui"
    bash -c "curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/aria2/install.sh"
    echo "aria2-webui hosting on port :8888 with rpc-secret "qwer1234"
    echo "Completed"
    pause_and_return
}

PS3=(Select your package: "
options=("Update&Upgrade" "Docker" "Samba" "SSH" "Plex" "Prowlarr" "Qbittorrent" "Transmission" "Aria2" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) Update&Upgrade ;;
            2) Docker ;;
            3) Samba ;;
            4) SSH ;;
            5) Plex ;;
            6) Prowlarr ;;
            7) qbittorrent ;;
            8) transmission ;;
            9) aria2 ;;
            10) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid"; exit 0 ;;
        esac
    done
done
