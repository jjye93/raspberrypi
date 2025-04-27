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
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/docker/install.sh)"
    echo "Completed"
    pause_and_return
}

Samba() {
    echo "Installing and Configuring Samba"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/samba/install.sh)"
    echo "Set username as 'admin' and password as 'qwer1234'"
    echo "Installation Completed"
    pause_and_return
}

SSH() {
    echo "Configuring SSH for root user"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/ssh/install.sh)"
    echo "Set username as 'root' and password as 'qwer1234'"
    echo "Completed"
    pause_and_return
}

Plex() {
    echo "Installing Plex"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/plex/install.sh)"
    echo "Completed"
    pause_and_return
}

Prowlarr() {
    echo "Installing Prowlarr"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/prowlarr/install.sh)"
    echo "Completed"
    pause_and_return
}

qbittorrent() {
    echo "Installing qbittorrent"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/qbittorrent/install.sh)"
    echo "Completed"
    pause_and_return
}

transmission() {
    echo "Installing transmission"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/transmission/install.sh)"
    echo "Completed"
    pause_and_return
}

aria2() {
    echo "Installing aria2-webui"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/aria2/install.sh)"
    echo "aria2-webui hosting on port :8888 with rpc-secret 'qwer1234'"
    echo "Completed"
    pause_and_return
}

casaos() {
    echo "Installing casaos"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/casaos/install.sh)"
    echo "Completed"
    pause_and_return
}

alist() {
    echo "Installing Alist"
    sudo bash -c "$(curl -fsSL https://alist.nn.ci/v3-en.sh)"
    echo "Completed"
    pause_and_return
}


PS3="Select your package: "
options=("Update & Upgrade" "Docker" "Samba" "SSH" "Plex" "Prowlarr" "Qbittorrent" "Transmission" "Aria2" "CasaOS" "Alist" "Exit")

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
            10) casaos ;;
            11) alist ;;
            12) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid selection. Try again." ;;
        esac
        break  # Exit select to redisplay the menu
    done
done
