#!/usr/bin/bash
echo "install mosquitto"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/smarthome/zigbee2mqtt/mosquitto/install.sh)"
echo "configured mosquitto with username "admin" and password "qwer1234""
wait 10s
echo "install zigbee2mqtt"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jjye93/raspberrypi/refs/heads/main/smarthome/zigbee2mqtt/zigbee2mqtt/install.sh)"
echo "zigbee2mqtt are hosted on port 9699"
echo "Completed"
