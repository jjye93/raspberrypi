echo "----------------------------------------------------------------"
echo "aria2-webui"
echo "----------------------------------------------------------------"
sudo mkdir -p /etc/aria2-webui
sudo git clone https://github.com/ziahamza/webui-aria2.git /etc/aria2-webui && cd /etc/aria2-webui
sudo apt-get install npm -y
sudo npm install -g pm2
pm2 start node-server.js
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u admin --hp /home/admin
pm2 save
echo "----------------------------------------------------------------"
echo "Completed"
echo "----------------------------------------------------------------"
sleep 5s
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/main/raspberrypi/pi.local/docker-run.sh |sudo bash
