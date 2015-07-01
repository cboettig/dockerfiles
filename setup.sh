#!/bin/bash

## SET your environmental variables to the sockets you want to use first
# Here we just set a few defaults. You ought to set these 

SSH=${SSH:=22}
## NOTE! Assumes login configured with SSH keys. see:
## https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2


## Note: All commands here are run as root unless otherwise stated


####################################################


# Allocate some swap space, particularly if we're on a small droplet 
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
## Make these changes permanent
echo "/swapfile       none    swap    sw      0       0" >> /etc/fstab
chown root:root /swapfile # redundant?
chmod 0600 /swapfile      # redundant? 


##################################################

# Install the latest version of Docker 
wget -qO- https://get.docker.com/ | sh

##################################################

## Create a new, not-root user: (uses the local user name)
adduser --gecos '' $USER
## Grant the user superuser privileges
echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

## Copy over authorized_keys and chown to user

cp -r /root/.ssh /home/$USER/ && chown -R $USER:$USER /home/$USER/.ssh

addgroup $USER docker

## Important: check now that you can log in as user over ssh, without pw,
## and user has sudo power. 


## Now that we have a non-root user, Prevent any root login over ssh:
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
## Must explicitly declare this due to Ubuntu's default "UsePAM yes" 
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
## Allow only our user to login:
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers $USER" >> /etc/ssh/sshd_config
## Change the default ssh port
#sed -i "s/Port 22/Port $SSH/" /etc/ssh/sshd_config

## NOTE! We'll need to use this on all future ssh calls, e.g.:
##    ssh -p $SSH $USER@ip-addreess
## Adjusting our local ssh/config is the best way to do this. 


## Reload to implement the new settings
systemctl restart ssh
#reload ssh


####################################################

## Install UFW -- Uncomplicated firewall configuration
apt-get update && apt-get -y install ufw fail2ban

## Docker needs to ufw to allow forwarding and port 2375
#sed -i s/DEFAULT_FORWARD_POLICY=\"DROP\"/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/ /etc/default/ufw
ufw reload
ufw allow 2375/tcp

## Allow ports for these services: 
ufw allow 22/tcp
ufw allow 80/tcp

ufw enable

###################################################

## Install fail2ban
## Configure fail2ban if ssh not 22
#cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# adjust [ssh] port section to monitor non-standard $SSH port in use.
# sed -i "s/^port * = ssh/port = $SSH/"    /etc/fail2ban/jail.conf

###################################################

## Install Tripwire.  Requires interactive work. 
## Assumes someone is going to read & interpret the log files
# apt-get install -y tripwire 


####################################################


## Some nice terminal settings ##

## Recursive history search 
echo '"\e[5~": history-search-backward' >> /etc/inputrc 
echo '"\e[6~": history-search-backward' >> /etc/inputrc



## Stay updated, for security purposes.  
apt-get update && apt-get dist-upgrade -y
## Clean up
apt-get autoremove -y


## Install some useful tools: 
apt-get install -y \
  git \
  vnstat \
  vim 

