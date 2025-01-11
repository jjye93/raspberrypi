#!/usr/bin/bash
echo "ssh"
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
sudo systemctl stop ssh
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sudo wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/ssh/sshd_config
sudo chmod 644 /etc/ssh/sshd_config 
sudo chown root:root /etc/ssh/sshd_config 
sudo systemctl start ssh
echo "complete"
