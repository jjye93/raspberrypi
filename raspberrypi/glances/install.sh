#!/usr/bin/bash
echo "Glances"
sudo apt-get install glances -y
sudo systemctl enable glances
sudo systemctl start glances
#port:61208
echo "Completed and host at port:61208"
