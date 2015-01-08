## This is my general-purpose / convenience image. 

## Most of my active but more mature projects provide their
## own minimal Dockerfiles based on a robust public image (e.g. hadleyverse), 
## providing a dockerfile that is more specific to the project and more stable.
## This dockerfile changes as the basic tools I'm using day-to-day change
## and should not be seen as a consistent base on which to extend anything

FROM rocker/hadleyverse
MAINTAINER Carl Boettiger "cboettig@gmail.com"

## Install my packages
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
		igraph \
&& installGithub.r \
    cboettig/populationdynamics \
    cboettig/pdg_control \
    cboettig/nonparametric-bayes \
    jrnold/ggthemes \
    sckott/analogsea \
		docopt/docopt.R \
&& install2.r --error -r http://r-nimble.org nimble \
&& rm -rf /tmp/downloaded_packages

## Gives user sudo rights 
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Development environment ##

RUN apt-get update && apt-get install -y vim-pathogen \
&& cd /home/rstudio && mkdir .vim && mkdir .vim/bundle \
&& cd /home/rstudio/.vim/bundle \
&& git clone https://github.com/tpope/vim-sensible.git \
&& git clone https://github.com/vim-pandoc/vim-pandoc.git \
&& git clone https://github.com/vim-pandoc/vim-pandoc-syntax.git \
&& git clone https://github.com/vim-pandoc/vim-rmarkdown.git \
&& git clone https://github.com/altercation/vim-colors-solarized.git \
&& cd

COPY vimrc /home/rstudio/.vimrc

CMD ["/bin/bash"]
