## This is my general-purpose / convenience image. 

## Most of my active but more mature projects provide their
## own minimal Dockerfiles based on a robust public image (e.g. hadleyverse), 
## providing a dockerfile that is more specific to the project and more stable.
## This dockerfile changes as the basic tools I'm using day-to-day change
## and should not be seen as a consistent base on which to extend anything

FROM rocker/ropensci 
MAINTAINER Carl Boettiger "cboettig@gmail.com"

## Install my packages
## 
RUN apt-get update && apt-get install -y \
    r-cran-R2jags \ 
    r-cran-snowfall \
    r-cran-expm \
&& install2.r --error \
    coda \
    deSolve \
    emdbook \
    kernlab \
    MASS \
    mcmc \
    MCMCpack \
    modeest \
    pander \
    R2jags \
    sde \
&& installGithub.r \
    cboettig/populationdynamics \
    cboettig/pdg_control \
    cboettig/nonparametric-bayes \
    jrnold/ggthemes \
&& install2.r --error --repos http://r-nimble.org nimble \
&& rm -rf /tmp/downloaded_packages


## Optionally gives user sudo rights and sets as default user
RUN adduser docker sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

