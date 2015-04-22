FROM cboettig/bce 

ENV R_BASE_VERSION 3.2.0

ENV PATH /usr/lib/rstudio-server/bin/:$PATH 
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV DEBIAN-FRONTEND noninteractive


COPY . /tmp
RUN cd /tmp \
  && ./r-base-recipe.sh \
  && ./rstudio-recipe.sh \
  && ./hadleyverse-recipe.sh \
  && mv userconf.sh /usr/bin/userconf.sh \
  && mv supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8787
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
