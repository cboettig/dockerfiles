# Provide a vanilla Ubuntu development environment running an ssh
# server. This allows students to ssh directly into a virtual environment
# running in an isolated container.
#
# CONFIGURATION & USE:
# Build the docker image: 
#
#     docker build -t ssh .
#
# Start the ssh server on port 2222:
#
#     docker run -d -p 2222:22 --name="ssh" ssh
#
# Add to the firewall permissions
#
#     sudo ufw add 2222/tcp
#
# From here I can now ssh in from the computer housing the private key pair to the public key 
# that is added to the image here.  However, that user doesn't have root access since we haven't
# provided a password.  
# 
# Use nsenter to enter the instance: 
#
#     docker run -v /usr/local/bin:/target jpetazzo/nsenter
#     nsenter -m -u -n -i -p -t `docker inspect --format '{{.State.Pid}}' ssh` /bin/bash
# 
#
# Create a password for the user to enable root access: 
# 
#    echo '$USER:<password>' | chpasswd
# 
# Can create other users and add them to sudoers or not as desired.  
#

# CUSTOMIZATION:
# 
# Adjust the FROM repository to provide the desired development environment.
# 
# Set USER enviromental variable as desired and provide authorized_keys file containing any
# public keys you want to configure.   

FROM     ubuntu:14.04
MAINTAINER Carl Boettiger "cboettig@gmail.com"

ENV USER cboettig 

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN adduser --disabled-password --gecos "" $USER 
RUN adduser $USER sudo 
ADD authorized_keys /home/$USER/.ssh/authorized_keys
RUN chown $USER /home/$USER/.ssh/authorized_keys

## Should we configure /etc/ssh/sshd_config PermitRootLogin, or AllowUsers?

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
