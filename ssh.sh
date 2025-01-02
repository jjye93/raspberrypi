#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Commence root-ssh account setting"
echo "----------------------------------------------------------------"
echo "Setting password for root..."
if ! command -v expect
then
    echo "Expect is not installed, installing..."
    sudo apt-get install -y expect
fi

expect <<EOF
spawn sudo passwd root
expect "New password:"
send "admin\r"
expect "Retype new password:"
send "admin\r"
expect eof
EOF
echo "Stopping ssh service..."
sudo systemctl stop ssh
echo "Backing up original sshd_config..."
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
echo "Downloading new smb.conf..."
sudo wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/sshd_config
echo "Setting correct permissions for sshd_config..."
sudo chmod 644 /etc/ssh/sshd_config 
sudo chown admin:root /etc/ssh/sshd_config 
echo "Starting ssh service..."
sudo systemctl start ssh
echo "----------------------------------------------------------------"
echo "root-ssh setup completed"
echo "----------------------------------------------------------------"
