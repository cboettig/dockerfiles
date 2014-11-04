#!/bin/bash

## SET your environmental variables to the sockets you want to use first
# Here we just set a few defaults. You ought to set these 

SSH=${SSH:=22}
RSTUDIO=${RSTUDIO:=8787}
USER=${USER:=rstudio}
PASSWORD=${PASSWORD:=rstudio}
GITLAB_WEB=${GITLAB_WEB:=10080}
GITLAB_SSH=${GITLAB_SSH:=10022}
DRONE=${DRONE:=8080}
SHINY=${SHINY:=3838}

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
curl -sSL https://get.docker.io/ubuntu/ | sh


##################################################

## Create a new, not-root user: (uses the local user name)
adduser --gecos '' $USER
## Grant the user superuser privileges
echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

## Now that we have a non-root user, Prevent any root login over ssh:
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
## Must explicitly declare this due to Ubuntu's default "UsePAM yes" 
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

## Allow only our user to login:
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "AllowUsers $USER" >> /etc/ssh/sshd_config


## Change the default ssh port
sed -i "s/Port 22/Port $SSH/" /etc/ssh/sshd_config

## NOTE! We'll need to use this on all future ssh calls, e.g.:
##    ssh -p $SSH $USER@ip-addreess
## Adjusting our local ssh/config is the best way to do this. 


## Reload to implement the new settings
reload ssh


####################################################

## Install UFW -- Uncomplicated firewall configuration
apt-get install ufw

## Docker needs to ufw to allow forwarding and port 2375
sed -i s/DEFAULT_FORWARD_POLICY=\"DROP\"/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/ /etc/default/ufw
ufw reload
ufw allow 2375/tcp

## Allow ports for these services: 
ufw allow $SSH/tcp
ufw allow $RSTUDIO/tcp

ufw enable
## Other services I might run: 
#ufw allow $GITLAB-SSH/tcp
#ufw allow $GITLAB-WEB/tcp
#ufw allow $DRONE/tcp
#ufw allow $SHINY/tcp


###################################################

## Install fail2ban
apt-get install fail2ban 

## Configure fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# adjust [ssh] port section to monitor non-standard $SSH port in use.


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
  git \     # we'll use below to install certain things
  vnstat    # Monitors network use (1 TB/month free on small instances)


###########################################

## Install nsenter: -- not needed now, docker 1.3 has docker exec -it <containerid> bash
# docker run -v /usr/local/bin:/target jpetazzo/nsenter
## alias appropriately
# echo 'function dock { sudo nsenter -m -u -n -i -p -t `docker inspect --format {{.State.Pid}} "$1"` /bin/bash; }' >> ~/.bashrc


# Launch containerized services: 

## Deploy RStudio on 8787 (with rich R environment installed)
docker run --name='rstudio' -d -p $RSTUDIO:8787 -e USER=$USER -e PASSWORD=$PASSWORD rocker/ropensci

## Configure additional users on the image:
# dock rstudio
# useradd -m $USER && echo "$USER:$PASSWORD" | chpasswd
# chown -R $USER:$USER /home/$USER

## build drone image from source:
git clone https://github.com/drone/drone.git
docker build -t drone/drone drone/
## Deploy Drone CI on 8080 (Then visit localhost:8080/install)
docker run --name='drone' -d -p $DRONE:80 --privileged drone/drone


## Deploy Gitlab: we need some data containers running first
docker run --name=postgresql -d \
  -e 'DB_NAME=gitlabhq_production' -e 'DB_USER=gitlab' -e 'DB_PASS=somepassword' \
  -v /opt/postgresql/data:/var/lib/postgresql \
  sameersbn/postgresql:latest
docker run --name=redis -d sameersbn/redis:latest

## launch gitlab, linking to them containers:
docker run --name=gitlab -d \
  --link postgresql:postgresql \
  --link redis:redisio \
  -p $GITLAB_WEB:80 -p $GITLAB_SSH:22 \
  -v /opt/gitlab/data:/home/git/data \
    sameersbn/gitlab:7.3.2-1
# Specific version matters. versions get software updates without numbers changing.
# Visit http://localhost:$GITLAB_WEB and login using the default username and password: root/5iveL!fe

## Deploy RStudio's shiny-server on 3838
docker run -d -p $SHINY:3838 cboettig/shiny

## Deploy OpenCPU on 443 
#docker run -t -d -p 5080:8006 -p 443:8007 jeroenooms/opencpu-dev

