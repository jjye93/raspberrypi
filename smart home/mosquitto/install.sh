#!/usr/bin/bash
echo "mosquitto"
sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt-get install expect -y
sudo apt-get install mosquitto -y
expect <<EOF
spawn sudo mosquitto_passwd -c /etc/mosquitto/passwd admin
expect "Password: "
send "qwer1234\r"
expect "Reenter password: "
send "qwer1234\r"
expect eof
EOF
sudo systemctl stop mosquitto
sudo mv /etc/mosquitto/mosquitto.conf /etc/mosquitto/mosquitto.conf.1
sudo wget -O /etc/mosquitto/mosquitto.conf https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smart%20home/mosquitto/mosquitto.conf
sudo chmod 777 /etc/mosquitto/mosquitto.conf
sudo systemctl start mosquitto
sudo systemctl enable mosquitto
echo "complete"
