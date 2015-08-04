FROM r-base

RUN cd opt \ 
  && wget https://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.7.tar.bz2 \
  && tar jxf *.tar.bz2 \
  && cd openmpi* \
  && ./configure --prefix=/usr/local/bin \
  && make install all

RUN R -e 'install.packages("Rmpi")'
RUN R -e 'install.packages("bigGP")'


