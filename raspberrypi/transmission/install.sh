#!/usr/bin/bash
echo "transmission"
sudo apt install build-essential cmake git libcurl4-openssl-dev libssl-dev -y 
sudo apt install libb64-dev libdeflate-dev libevent-dev libminiupnpc-dev libnatpmp-dev libpsl-dev libsystemd-dev -y
sudo apt install gettext libgtkmm-3.0-dev -y
sudo git clone --recurse-submodules https://github.com/transmission/transmission /etc/transmission
cd /etc/transmission
cmake -B build -DCMAKE_BUILD_TYPE=Release
cd build && cmake --build .
sudo  cmake --install .
echo "complete"
