## Use as a base for ssh to run as an ssh image 
FROM rocker/ropensci 
MAINTAINER Carl Boettiger "cboettig@gmail.com"

## Hardwire custom configuration
RUN echo '"\e[5~": history-search-backward' >> /etc/inputrc && echo '"\e[6~": history-search-backward' >> /etc/inputrc

## Package installations
RUN apt-get update && apt-get install -y vim



## Install my packages
## Note: these are for convenience / common use.  
## Stongly suggested that mature projects provide their
## own Dockerfiles based on a robust public image.  
## 
RUN apt-get update && apt-get install -y \
    r-cran-R2jags \ 
    r-cran-snowfall \
    r-cran-expm \
&& install2.r --error \
    coda \
    emdbook \
    kernlab \
    MASS \
    mcmc \
    MCMCpack \
    modeest \
    pander \
    R2jags \
&& installGithub.r \
    cboettig/pdg_control \
    cboettig/nonparametric-bayes \
    jrnold/ggthemes \ 
    hadley/reshape \ 
&& rm -rf /tmp/downloaded_packages


## Optionally gives user sudo rights and sets as default user
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

