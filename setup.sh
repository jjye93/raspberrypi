#!/usr/bin/bash

echo "Raspberry Pi 5 installation script"
echo "Please select a package to install"

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

Update_Upgrade() {
    echo "Running Update & Upgrade"
    sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt autoremove -y && sudo apt-get autoclean -y
    echo "Completed"
    pause_and_return
}

Docker() {
    echo "Installing Docker"
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    echo "Completed"
    pause_and_return
}

Samba() {
    echo "Installing and Configuring Samba"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/samba/install.sh)"
    echo "Set username as 'admin' and password as 'qwer1234'"
    echo "Installation Completed"
    pause_and_return
}

SSH() {
    echo "Configuring SSH for root user"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/ssh/install.sh)"
    echo "Set username as 'root' and password as 'qwer1234'"
    echo "Completed"
    pause_and_return
}

Plex() {
    echo "Installing Plex"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/plex/install.sh)"
    echo "Completed"
    pause_and_return
}

Prowlarr() {
    echo "Installing Prowlarr"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/prowlarr/install.sh)"
    echo "Completed"
    pause_and_return
}

qbittorrent() {
    echo "Installing qbittorrent"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/qbittorrent/install.sh)"
    echo "Completed"
    pause_and_return
}

transmission() {
    echo "Installing transmission"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/transmission/install2.sh)"
    echo "Completed"
    pause_and_return
}

aria2() {
    echo "Installing aria2-webui"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/aria2/install.sh)"
    echo "aria2-webui hosting on port :8888 with rpc-secret 'qwer1234'"
    echo "Completed"
    pause_and_return
}

PS3="Select your package: "
options=("Update & Upgrade" "Docker" "Samba" "SSH" "Plex" "Prowlarr" "Qbittorrent" "Transmission" "Aria2" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) Update_Upgrade ;;
            2) Docker ;;
            3) Samba ;;
            4) SSH ;;
            5) Plex ;;
            6) Prowlarr ;;
            7) qbittorrent ;;
            8) transmission ;;
            9) aria2 ;;
            10) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break  # Exit select to redisplay the menu
    done
done
