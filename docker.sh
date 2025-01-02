#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Commence Docker Setup"
echo "----------------------------------------------------------------"
sudo apt-get install -y docker.io docker-compose
echo "----------------------------------------------------------------"
sudo usermod -aG docker admin
sudo systemctl enable docker.service
sudo systemctl start docker.service
echo "----------------------------------------------------------------"
echo "Docker Setup Completed"
echo "----------------------------------------------------------------"
