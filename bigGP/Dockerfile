FROM r-base

## Add the build-depends repos
RUN echo 'deb http://debian-r.debian.net/debian-r/ unstable main' >> /etc/apt/sources.list \
  && gpg --keyserver keyserver.ubuntu.com --recv-keys AE05705B842492A68F75D64E01BF7284B26DD379 \
  && gpg --export AE05705B842492A68F75D64E01BF7284B26DD379  | apt-key add - \
  && echo 'deb-src http://debian-r.debian.net/debian-r/ unstable main' >> /etc/apt/sources.list \
  && echo 'deb-src http://http.debian.net/debian testing main' >> /etc/apt/sources.list

## Note that ssh is also required! http://www.open-mpi.org/community/lists/users/2010/07/13503.php
RUN apt-get update \
  && apt-get build-dep -y r-cran-rmpi \
  && apt-get -y install ssh

## Chris recommends openmpi >= 1.8.5 in place of ubuntu stock repos
RUN cd opt \
  && wget https://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.7.tar.bz2 \
  && tar jxf *.tar.bz2 \
  && cd openmpi* \
  && ./configure --prefix=/usr/local/openmpi-1.8.7 \
  && make install all

## Okay now we're set to install with config args for the new openmpi libs 
RUN R -e 'install.packages("Rmpi", configure.args = c("--with-mpi=/usr/local/openmpi-1.8.7"))'
RUN R -e 'install.packages("bigGP", configure.args = c("--with-mpi=/usr/local/openmpi-1.8.7"))'


