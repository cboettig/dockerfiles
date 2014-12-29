#!/bin/bash
# Description: A Dockerfile to create a CRAN-like package repository,
# http://cran.r-project.org/doc/manuals/R-admin.html#Setting-up-a-package-repository
#
# License: MIT
# Use: 
#		Build the package environment with this script	
# To serve a CRAN-like repository from port 5555:
#
#     docker build -t r-repo .
#     docker run -d -p 5555:80 r-repo
# 

alias DOCKER='docker run -v $(pwd):/host --workdir /host --rm -it rocker/ropensci'
shopt -s expand_aliases

mkdir -p public-html/R/src/contrib 
cd public-html/R/src/contrib 

wget https://github.com/egonw/rrdf/archive/master.zip 
unzip master.zip 
## build package
DOCKER R CMD build rrdf-master/rrdflibs
DOCKER R CMD build rrdf-master/rrdf
## Generate the PACKAGES index file
DOCKER Rscript -e  "tools::write_PACKAGES()"
## Clean up
rm -rf rrdf-master *.zip
