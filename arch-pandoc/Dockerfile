FROM l3iggs/archlinux
RUN mkdir -p /opt/pandoc \
  && curl -o /tmp/pandoc-1.13.1.zip https://s3.amazonaws.com/rstudio-buildtools/pandoc-1.13.1.zip 
RUN pacman -S --noconfirm unzip
RUN unzip -j /tmp/pandoc-1.13.1.zip pandoc-1.13.1/linux/debian/x86_64/pandoc -d /opt/pandoc \
  && chmod +x /opt/pandoc/pandoc \
  && unzip -j /tmp/pandoc-1.13.1.zip pandoc-1.13.1/linux/debian/x86_64/pandoc-citeproc -d /opt/pandoc \
  && chmod +x /opt/pandoc/pandoc-citeproc \
  && export PATH=$PATH:/opt/pandoc

CMD pandoc
