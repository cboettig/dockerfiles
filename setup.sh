#!/bin/bash

## Stay updated 
sudo apt-get -q update && sudo apt-get -qy dist-upgrade


## UFW -- Uncomplicated firewall configuration
sudo apt-get install ufw


## Docker needs to ufw to allow forwarding and port 2375
sudo sed -i s/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT" /etc/default/ufw
sudo ufw reload
sudo ufw allow 2375/tcp

## Allow services: 
sudo ufw allow $DRONE/tcp
sudo ufw allow $SSH/tcp
sudo ufw allow $SSH-CONTAINER/tcp
sudo ufw allow $GITLAB-SSH/tcp
sudo ufw allow $GITLAB-WEB/tcp


sudo apt-get install fail2ban 
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# adjust [ssh] port section to monitor non-standard $SSH port in use.

## Requires interactive work
sudo apt-get install -y tripwire 



# Allocate some swap space for a digitalocean image
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab

# Redundant? 
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile


# Install docker
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
