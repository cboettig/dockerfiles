FROM debian:wheezy
MAINTAINER Carl Boettiger <cboettig@ropensci.org>

RUN  apt-get update && apt-get install -y wget tar perl fontconfig \
     && wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
     && tar -xvf *.tar.gz 
RUN cd install-tl-* \
    && wget --no-check-certificate https://github.com/leodido/dockerfiles/raw/master/texlive:2014/full.profile \
    && ./install-tl --profile full.profile

#RUN apt-get update && apt-get install -y \
#    texlive-full
