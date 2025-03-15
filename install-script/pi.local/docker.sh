#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
curl https://get.docker.com |sudo bash
sudo usermod -aG docker admin
sudo systemctl start docker.service
sudo systemctl start containerd.service
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
sleep 5s
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/samba.sh | sudo bash
