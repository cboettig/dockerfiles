# For some reason this isn't working when dockerized. Works fine 
# only when run in foreground natively.
# 
# use: 
# run in deamonized:
#     docker run -d -p 56780:56780 lifx
#     
# see https://github.com/chendo/lifx-http and issue curl commands locally
#
# Or run interactively:
#     docker run --rm -it -p 56780:56780 lifx /bin/bash
#
# and follow the same instructions, issuing curl commands in the container 

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update 
RUN apt-get -y install ruby2.0 ruby2.0-dev curl 
RUN gem2.0 install lifx-http 

EXPOSE 56780

CMD ["/usr/local/bin/lifx-http"]
