#!/usr/bin/bash
echo "----------------------------------------------------------------"
echo "Commence Samba Setup"
echo "----------------------------------------------------------------"
echo "Installing Samba..."
sudo apt-get install -y samba 
echo "Stopping Samba service..."
sudo systemctl stop samba 
echo "Backup smb.conf"
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.1 
sudo wget -O /etc/samba/smb.conf https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/smb.conf
echo "Setting correct permissions for smb.conf..."
sudo chmod 644 /etc/samba/smb.conf
sudo chown root:root /etc/samba/smb.conf
echo "Starting Samba service..."
sudo systemctl start samba 
echo "Setting Samba password for user 'admin'..."
if ! command -v expect &> /dev/null
then
    echo "Expect is not installed, installing..."
    sudo apt-get install -y expect
fi

expect <<EOF
spawn sudo smbpasswd -a admin
expect "New SMB password:"
send "admin\r"
expect "Retype new SMB password:"
send "admin\r"
expect eof
EOF
echo "Restarting Samba service..."
sudo systemctl restart samba
echo "----------------------------------------------------------------"
echo "Samba configuration is complete. SMB user 'admin' has been created with the password 'admin'."
echo "----------------------------------------------------------------"
