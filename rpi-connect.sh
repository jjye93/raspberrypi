#!/bin/bash


echo "Starting the sign-in process..."
tempfile=$(mktemp)
rpi-connect signin > "$tempfile" 2>&1 &
signin_pid=$!

# Extract the authentication URL
auth_url=""
while [[ -z "$auth_url" ]]; do
    auth_url=$(grep -o "https://connect.raspberrypi.com/verify/[A-Za-z0-9\-]*" "$tempfile")
    if [[ -n "$auth_url" ]]; then
        break
    fi
    echo "Waiting for authentication link to be generated..."
    sleep 1
done

# Display the link to the user
echo "Please complete the sign-in process by visiting the following URL on another device:"
echo "$auth_url"
echo ""
echo "Waiting for sign-in to complete..."

# Wait for sign-in completion
wait $signin_pid
if [[ $? -ne 0 ]]; then
    echo "Error: Sign-in process did not complete successfully."
    exit 1
fi

# Step 3: Enable lingering for the current user
echo "Enabling linger for the current user..."
sudo loginctl enable-linger "$(whoami)"
if [[ $? -eq 0 ]]; then
    echo "✓ Linger enabled successfully."
else
    echo "Error: Failed to enable linger. Please run 'sudo loginctl enable-linger $(whoami)' manually."
fi

echo "Setup complete!"

# Call next script
echo "Calling Docker Setup..."
curl https://raw.githubusercontent.com/jjye93/config-file/refs/heads/breakdown-script/docker.sh | sudo bash
