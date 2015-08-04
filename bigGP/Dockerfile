FROM r-base

RUN apt-get update && apt-get -y install cdbs mpi-default-dev mpi-default-bin

RUN cd opt \
  && wget https://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.7.tar.bz2 \
  && tar jxf *.tar.bz2 \
  && cd openmpi* \
  && ./configure --prefix=/usr/local/openmpi-1.8.7 \
  && make install all

RUN R -e 'install.packages("Rmpi", configure.args = c("--with-mpi=/usr/local/openmpi-1.8.7"))'
RUN R -e 'install.packages("bigGP", configure.args = c("--with-mpi=/usr/local/openmpi-1.8.7"))'


