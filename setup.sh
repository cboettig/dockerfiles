#!/bin/bash

## SET your environmental variables to the sockets you want to use first
# Here we just set a few defaults, though ideally you may want different values
SSH=${SSH:=22}
RSTUDIO=${RSTUDIO:=8787}


# NOTE! Assumes login configured with SSH keys.  https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
## Note: All run as root unless otherwise stated



## Stay updated, for security purposes.  
apt-get -q update && apt-get -qy dist-upgrade

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
curl -sSL https://get.docker.io/ubuntu/ | sh


##################################################

## Create a new, not-root user: (uses the local user name)
adduser --gecos '' $USER
## Grant the user superuser privileges
RUN echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

## Now that we have a non-root user, Prevent any root login over ssh:
sed -i 's/PermitRootLogin yes/PermitRootLogin no' /etc/ssh/sshd_config

## Allow only our user to login:
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers $USER" >> /etc/ssh/sshd_config

## Change the default ssh port
sed -i "s/Port 22/Port $SSH" /etc/ssh/sshd_config

## NOTE! We'll need to use this on all future ssh calls, e.g.:
##    ssh -p $SSH $USER@ip-addreess
## Adjusting our local ssh/config is the best way to do this. 


## Reload to implement the new settings
reload ssh


####################################################

## Install UFW -- Uncomplicated firewall configuration
apt-get install ufw

## Docker needs to ufw to allow forwarding and port 2375
sed -i s/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT" /etc/default/ufw
ufw reload
ufw allow 2375/tcp

## Allow ports for these services: 
ufw allow $SSH/tcp
ufw allow $RSTUDIO/tcp


## Other services I might run: 
# ufw allow $SSH-CONTAINER/tcp
# ufw allow $GITLAB-SSH/tcp
# ufw allow $GITLAB-WEB/tcp
# ufw allow $DRONE/tcp

## Install fail2ban
apt-get install fail2ban 

## Configure fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# adjust [ssh] port section to monitor non-standard $SSH port in use.


## Instal Tripwire.  Requires interactive work
# apt-get install -y tripwire 




