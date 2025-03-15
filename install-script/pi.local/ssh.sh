#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "SSH"
echo "----------------------------------------------------------------"
sudo apt install expect -y
expect <<EOF
spawn sudo passwd root
expect "New password:"
send "admin\r"
expect "Retype new password:"
send "admin\r"
expect eof
EOF
sudo systemctl stop ssh
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.1
sudo wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/ssh/sshd_config
sudo chmod 644 /etc/ssh/sshd_config
sudo chown root:root /etc/ssh/sshd_config
sudo systemctl start ssh
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
sleep 5s
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/plex.sh | sudo bash
