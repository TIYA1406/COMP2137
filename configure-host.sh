#!/bin/bash



# Ensure the script is run as root

if [ "$(id -u)" -ne 0 ]; then

  echo "Run as root"

  exit 1

fi



# Desired hostname and IP address (hardcoded)

DESIRED_NAME="TIYA123"

DESIRED_IP="192.168.1.100"



# Update hostname

echo "$DESIRED_NAME" > /etc/hostname

sed -i "s/$(hostname)/$DESIRED_NAME/" /etc/hosts

hostname "$DESIRED_NAME"

echo "Hostname changed to $DESIRED_NAME"



# Update IP address in /etc/hosts

CURRENT_IP=$(hostname -I | awk '{print $1}')

if [ "$CURRENT_IP" != "$DESIRED_IP" ]; then

  # Remove old IP entry

  sed -i "/$CURRENT_IP/d" /etc/hosts

  # Add new IP entry

  echo "$DESIRED_IP $(hostname)" >> /etc/hosts

fi



# Update IP address in Netplan configuration

NETPLAN_FILE=$(ls /etc/netplan/*.yaml)

if [ -f "$NETPLAN_FILE" ]; then

  sed -i "s/addresses: .*/addresses: [$DESIRED_IP]/" "$NETPLAN_FILE"

  netplan apply

  echo "IP address changed to $DESIRED_IP"

else

  echo "Netplan configuration file not found."

fi



# Remove existing entry if it exists and add the new one

sed -i "/$DESIRED_NAME/d" /etc/hosts

echo "$DESIRED_IP $DESIRED_NAME" >> /etc/hosts



echo "Hosts entry updated: $DESIRED_IP $DESIRED_NAME"
