FROM rocker/hadleyverse 
MAINTAINER Carl Boettiger cboettig@ropensci.org

RUN apt-get update && apt-get -y install \
		node \
		bundler \
    ruby-dev \
	&& install2.r --error --repos='http://yihui.name/xran' servr

COPY Gemfile /data/Gemfile

EXPOSE 4321

RUN adduser docker sudo \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
	&& chown -R docker:docker /data

USER docker
WORKDIR /data
RUN bundle install 

CMD Rscript -e 'servr::jekyll(dir = "_site-source/", host = "0.0.0.0")'
