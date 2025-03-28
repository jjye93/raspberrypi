#!/usr/bin/bash

echo "installing node-red"
bash <(curl -fsSL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
echo "completed"
