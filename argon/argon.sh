#!/usr/bin/bash
echo "Argon40 installation script"
echo "Please select your case model"

Argon-Neo() {
    echo "Installing Argon Neo Configuration"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/argon/ArgonNeo5.sh)"
    echo "Completed"
    sudo reboot
}

Argon-One-V3() {
    echo "Installing Argon One V3 Configuration"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/argon/ArgonOneV3.sh)"
    echo "Completed"
    sudo reboot
}

Argon-One-V5() {
    echo "Installing Argon One V5 Configuration"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/argon/ArgonOneV5.sh)"
    echo "Completed"
    sudo reboot
}

PS3="Select your model: "
options=("Argon Neo" "Argon One V3" "Argon One V5" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) Argon-Neo ;;
            2) Argon-One-V3 ;;
            3) Argon-One-V5 ;;
            4) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid"; exit 0 ;;
        esac
    done
done
