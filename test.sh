#!/usr/bin/bash

pause_and_return() {
		echo "Continue or Quit?"
		select next_step in "Continue" "Quit"; do
				case $REPLY in
						1) break ;;
						2) echo "Exiting..."; exit 0 ;;
						*) echo "Invalid"; exit 0 ;;
				esac
		done
}

Portainer() {
		echo "Installing Portainer..."
		curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/portainer/install.sh | sudo bash
		echo "Portainer installation completed!"
		pause_and_return
}

Aria2-webui() {
		echo "Installing Aria2-webui..."
		curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/aria2/install.sh | sudo bash
		echo "Aria2-webui installation completed!"
		pause_and_return
}

Qbittorrent() {
		echo "Installing Qbittorrent..."
		curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/qbittorrent/install.sh | sudo bash
		echo "access in http://host:8081; username: admin; password: adminadmin"
		echo "Qbittorrent installation completed!"
		pause_and_return
}

Transmission() {
		echo "Installing Transmission..."
		curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/qbittorrent/install.sh |sudo bash
		echo "access Transmission at http://host:9091; username: admin; password: adminadmin"
		echo "Transmission installation completed!"
		pause_and_return
}

PS3="Select for installation: "
options=("Portainer" "Aria2-webui" "Qbittorrent" "Transmission" "Quit")

while true; do
		select choice in "${options[@]}"; do
				case $REPLY in
						1) Portainer ;;
						2) Aria2-webui ;;
						3) Qbittorrent ;;
						4) Transmission ;;
						5) echo "Exiting..."; break ;;
						*) echo "Invalid. Please try again." ;;
				esac
		done
done
