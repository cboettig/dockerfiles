## Use as a base for ssh to run as an ssh image 
FROM docker/ropensci:dev
MAINTAINER Carl Boettiger "cboettig@gmail.com"


## Nice behavior 
RUN echo '"\e[5~": history-search-backward' >> /etc/inputrc && echo '"\e[6~": history-search-backward' >> /etc/inputrc

## Update
RUN sudo apt-get -qq update && sudo apt-get -qy dist-upgrade 
RUN apt-get -y install vim 

## Custom packages

## Create a non-root user & a home directory for them
RUN adduser --disabled-password --gecos '' docker

## (Optionally) add the user to sudoers (without password)
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to non-root user & set default working directory.
USER docker

## Just add development tools? 
## Alias common utilities as containers? (R, labnotebook, pandoc, even vim)  Is this silly? (e.g. forfit using shared libraries)

