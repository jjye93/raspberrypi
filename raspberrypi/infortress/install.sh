#!/usr/bin/bash
echo "infortress"
sudo mkdir -p /etc/infortress
sudo wget -O /etc/infortress/infortresserver https://infortress.s3.cn-northwest-1.amazonaws.com.cn/infortresserver/v1.0.21/linux/arm64/infortresserver
cd /etc/infortress
sudo chmod +x infortresserver
sudo ./infortresserver install
sudo ./infortresserver start
cd
echo "complete"
