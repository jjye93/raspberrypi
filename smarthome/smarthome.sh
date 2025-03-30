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

docker() {
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/install-script/docker/install.sh)"
    echo "Completed"
}

HomeBridge() {
    echo "Installing HomeBridge"
    curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg  > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list > /dev/null
    sudo apt-get install homebridge -y
    echo "Completed" 
    pause_and_return   
}

Zigbee2MQTT() {
    echo "Installing Zigbee2MQTT"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/smarthome/zigbee2mqtt/install.sh)"
    echo "Completed"
    pause_and_return
}

NodeRed() {
    echo "Installing NodeRed..."
    bash <(curl -fsSL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
    echo "Completed"
    pause_and_retirn
}

HomeAssistant() {
    echo "installing HomeAssistant"
    if command -v docker &> /dev/null; then
        echo "Docker is already installed."
    else
        echo "Docker not found. Installing..."
        docker
    fi
    sudo mkdir -p /etc/homeassistant
    sudo wget -O /etc/homeassistant/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/docker-compose/homeassistant/compose.yml
    sudo docker compose -f /etc/homeassistant/compose.yml up -d
    echo "completed"
    pause_and_return  
}

MatterBridge() {
    echo "Installing Matterbridge"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/smarthome/matterbridge/node/install.sh)"
    echo "Completed"
    pause_and_return
}

MatterBridge-Docker() {
    echo "Installing Matterbridge(Docker)"
    if command -v docker &> /dev/null; then
        echo "Docker is already installed."
    else
        echo "Docker not found. Installing..."
        docker
    fi
    sudo mkdir -p /etc/matterbridge
    sudo wget -O /etc/matterbridge/compose.yml  https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/smarthome/matterbridge/docker-compose/compose.yml
    sudo docker compose -f /etc/matterbridge/compose.yml up -d
    echo "completed"
    pause_and_return
}

PS3="Select your package: "
options=("HomeBridge" "Zigbee2MQTT" "NodeRed" "HomeAssistant" "MatterBridge" "MatterBridge" "Exit")

while true; do
    select choice in "${options[@]}"; do
        case $REPLY in
            1) HomeBridge ;;
            2) Zigbee2MQTT ;;
            3) NodeRed ;;
            4) HomeAssistant ;;
            5) MatterBridge ;;
            6) MatterBridge-Docker ;;
            4) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid..." ;;
        esac
        break
    done
done