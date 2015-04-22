#!/bin/bash

## Add binaries for more CRAN packages, deb-src repositories in case we need `apt-get build-dep`
echo 'deb http://debian-r.debian.net/debian-r/ unstable main' >> /etc/apt/sources.list \
  && gpg --keyserver keyserver.ubuntu.com --recv-keys AE05705B842492A68F75D64E01BF7284B26DD379 \
  && gpg --export AE05705B842492A68F75D64E01BF7284B26DD379  | apt-key add - \
  && echo 'deb-src http://debian-r.debian.net/debian-r/ unstable main' >> /etc/apt/sources.list \
  && echo 'deb-src http://http.debian.net/debian testing main' >> /etc/apt/sources.list


apt-get update \
  && apt-get install -y --no-install-recommends \
    ghostscript \
    imagemagick \
    lmodern \
    texlive-fonts-recommended \
    texlive-humanities \
    texlive-latex-extra \
    texinfo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && cd /usr/share/texlive/texmf-dist \
  && wget http://mirrors.ctan.org/install/fonts/inconsolata.tds.zip \
  && unzip inconsolata.tds.zip \
  && rm inconsolata.tds.zip \
  && echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \
  && mktexlsr \
  && updmap-sys

## Install some external dependencies. 360 MB
apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    default-jdk \
    default-jre \
    libcairo2-dev/unstable \
    libgsl0-dev \
    libmysqlclient-dev \
    libpq-dev \
    libsqlite3-dev \
    libv8-dev \
    libxslt1-dev \
    libxt-dev \
    r-cran-rgl \
    r-cran-rsqlite.extfuns \
    vim \
  && R CMD javareconf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

## Install the R packages. 210 MB
install2.r --error \
    devtools \
    dplyr \
    ggplot2 \
    haven \
    httr \
    knitr \
    packrat \
    reshape2 \
    rmarkdown \
    rvest \
    readr \
    readxl \
    testthat \
    tidyr \
    shiny \
## Manually install (useful packages from) the SUGGESTS list of the above packages.
## (because --deps TRUE can fail when packages are added/removed from CRAN)
&& Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("BiocInstaller")' \
&& install2.r --error \
    base64enc \
    Cairo \
    codetools \
    data.table \
    downloader \
    gridExtra \
    gtable \
    hexbin \
    Hmisc \
    jpeg \
    Lahman \
    lattice \
    MASS \
    PKI \
    png \
    microbenchmark \
    mgcv \
    mapproj \
    maps \
    maptools \
    mgcv \
    multcomp \
    nlme \
    nycflights13 \
    quantreg \
    Rcpp \
    rJava \
    roxygen2 \
    RMySQL \
    RPostgreSQL \
    RSQLite \
    testit \
    V8 \
    XML \
&& installGithub.r \
    hadley/lineprof \
    hadley/xml2 \
    hadley/purrr \
    dgrtwo/broom \
    rstudio/rticles \
    jimhester/covr \
    ramnathv/htmlwidgets \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds

