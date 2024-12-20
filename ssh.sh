#!/usr/bin/bash
set -e

echo "----------------------------------------------------------------"
echo "Commence root-ssh account setting"
echo "----------------------------------------------------------------"
echo "Setting password for root..."
if ! command -v expect &> /dev/null
then
    echo "Expect is not installed, installing..."
    sudo apt-get install -y expect || handle_error
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
sudo systemctl stop ssh || handle_error
echo "Backing up original sshd_config..."
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.1 || handle_error
echo "Downloading new smb.conf..."
sudo wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/sshd_config || handle_error
echo "Setting correct permissions for sshd_config..."
sudo chmod 644 /etc/ssh/sshd_config || handle_error
sudo chown root:root /etc/ssh/sshd_config || handle_error
echo "Starting ssh service..."
sudo systemctl start ssh || handle_error
echo "----------------------------------------------------------------"
echo "root-ssh setup completed"
echo "----------------------------------------------------------------"
