#!/usr/bin/bash
echo "immich"
sudo apt update && sudo apt full-upgrade -y
sudo apt install curl bash -y
cd /etc && curl -o- https://raw.githubusercontent.com/immich-app/immich/main/install.sh | sudo bash
echo "completed and host at port :2283"
