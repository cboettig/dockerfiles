## Use as a base for ssh to run as an ssh image 
FROM rocker/ropensci 
MAINTAINER Carl Boettiger "cboettig@gmail.com"

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
    deSolve \
&& installGithub.r \
    cboettig/populationdynamics \
    cboettig/pdg_control \
    cboettig/nonparametric-bayes \
    jrnold/ggthemes \
&& install2.r --error --repos http://r-nimble.org nimble \
&& rm -rf /tmp/downloaded_packages


## Optionally gives user sudo rights and sets as default user
RUN adduser docker sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

