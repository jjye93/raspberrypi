#!/usr/bin/bash
echo "Argon40 installation script"
echo "please select your case model"

Argon-Neo() {
    echo "Installing Argon Neo Configuration"
    curl https://download.argon40.com/argon-eeprom.sh | bash && curl https://download.argon40.com/argonneo5.sh | bash
    echo "Completed"
    exit 0
}

Argon-One-V3() {
    echo "Installing Argon One V3 Configuration"
    curl https://download.argon40.com/argon-eeprom.sh | bash && curl https://download.argon40.com/argon1.sh | bash
    echo "Completed"
    exit 0
}

Argon-One-V5() {
    echo "Installing Argon One V5 Configuration"
    curl https://download.argon40.com/argon-eeprom.sh | bash && curl https://download.argon40.com/argon1v5.sh | bash
    echo "Completed"
    exit 0
}
PS3="Select your model: "
options=("Argon Neo" "Argon One V3" "Argon One V5" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) Argon-Neo ;;
            2) Argon-One-V3 ;;
            3) Argon-One-V5 ;;
            4) echo "Exiting..."; break ;;
            *) echo "Invalid"; break ;;
        esac
    done
done
