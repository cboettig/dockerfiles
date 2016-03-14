FROM jupyter/systemuser

RUN apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
	texlive-latex-extra \
	texlive-generic-recommended

ADD resystemuser.sh /srv/singleuser/resystemuser.sh

RUN pip install --ignore-installed datascience==0.5.12
RUN pip install okpy==1.5.1
RUN pip install pypandoc

# For geospatial connector
RUN conda install --yes gdal==2.0.0 libgdal==2.0.0
RUN pip install geopy==1.11.0
RUN pip install pyproj==1.9.4
RUN pip install shapely==1.5.13

# Disable Python 2 kernel
RUN mv /usr/local/share/jupyter/kernels/python2 /var/tmp/

CMD ["sh", "/srv/singleuser/resystemuser.sh"]
