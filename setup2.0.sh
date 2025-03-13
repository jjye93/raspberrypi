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
)

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

PS3=(Select your package: "
options=("Update&Upgrade" "Docker" "Samba" "SSH" "Plex"

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) Update&Upgrade ;;
            2) Docker ;;
            3) Samba ;;
            4) SSH ;;
            4) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid"; exit 0 ;;
        esac
    done
done
