#!/usr/bin/bash

echo "Raspberry Pi 5 SmartHome Installation script"
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

HomeBridge() {
    echo "Installing HomeBridge"
    curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
    sudo apt-get install homebridge -y
    echo "Completed"    
}

PS3="Select your package: "
options=("HomeBridge" "Zigbee2MQTT" "NodeRed" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) HomeBridge ;;
            2) Zigbee2MQTT ;;
            3) NodeRed ;;
            4) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid..." ;;
        esac
        break
    done
done