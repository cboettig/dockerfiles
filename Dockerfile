FROM cboettig/ropensci:latest
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Remain current
RUN apt-get update -qq && apt-get dist-upgrade -y

## LaTeX dependencies for building the manuscript
RUN apt-get install -y texlive-humanities lmodern texlive-fonts-recommended texlive-latex-extra

## Add the working directory and make user-editable
ADD . /home/rstudio/docker
RUN chmod -R 777 /home/rstudio/docker
