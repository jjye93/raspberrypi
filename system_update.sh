#!/usr/bin/bash
set -e

echo "----------------------------------------------------------------"
echo "Commence System Upgrade"
echo "----------------------------------------------------------------"
sudo apt-get update && sudo apt-get upgrade -y || handle_error "System Upgrade"
echo "----------------------------------------------------------------"
echo "System Upgrade Completed"
echo "----------------------------------------------------------------"

# Call next script
echo "Calling Argon Setup..."
curl -fsSL 
