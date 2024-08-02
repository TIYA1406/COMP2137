#!/bin/bash

# Set variables
INTERFACE="eth0"
ADDRESS="192.168.16.21/24"
HOSTNAME="server1"


# Configure network interface
#echo "Configuring network interface..."
#sudo netplan apply
#sudo ip addr add $ADDRESS dev $INTERFACE
#sudo ip link set $INTERFACE up

# Variables (Replace with actual interface and IP address)
INTERFACE="eth0"       # Replace with your network interface
ADDRESS="192.168.1.100" # Replace with your desired IP address




# Install and configure Apache
echo "Installing and configuring Apache..."
sudo apt update
sudo apt install -y apache2

echo "Installing and configuring Squid..."
sudo apt update
sudo apt install -y squid



echo "Installing and configuring firewall (ufw)"
sudo apt update
sudo apt install -y ufw
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow squid
sudo ufw enable


# Print summary of changes
echo "Summary of changes:"
echo "Network interface configured: $INTERFACE $ADDRESS"
echo "Apache installed and configured"
echo "Squid installed and configured"
echo "Firewall configured"
