## Use as a base for ssh to run as an ssh image 
FROM cboettig/rstudior:dev
MAINTAINER Carl Boettiger "cboettig@gmail.com"


## Nice behavior 
RUN echo '"\e[5~": history-search-backward' >> /etc/inputrc && echo '"\e[6~": history-search-backward' >> /etc/inputrc

## Update
RUN sudo apt-get -qq update && sudo apt-get -qy dist-upgrade 
RUN apt-get -y install vim 

## Custom packages
RUN Rscript -e 'install.packages("knitcitations")'


## switch to a non-root user. We have to create the user first or we'll get an error when launching the container. 
RUN adduser --disabled-password --gecos '' cboettig
RUN adduser cboettig sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER cboettig
RUN mkdir /home/cboettig/R
RUN echo 'options("repos"="http://cran.rstudio.com", encoding="UTF-8"); .libPaths("/home/cboettig/R")' > /home/cboettig/.Rprofile


## Just add development tools? 
## Alias common utilities as containers? (R, labnotebook, pandoc, even vim)  Is this silly? (e.g. forfit using shared libraries)

