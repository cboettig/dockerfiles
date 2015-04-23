#!/bin/bash
set -e

## Tex configuration for inconsolata fonts needed to build R package manuals. ick.
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
    libcairo2-dev \
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
  && R CMD javareconf 

## Install the R packages. 210 MB
r -e 'source("http://bioconductor.org/biocLite.R"); biocLite("BiocInstaller")' \
  && install2.r --error --repo http://cran.rstudio.com \
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

