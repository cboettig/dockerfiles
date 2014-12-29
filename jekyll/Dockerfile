FROM rocker/hadleyverse 
MAINTAINER Carl Boettiger cboettig@ropensci.org

RUN apt-get update && apt-get -y install \
		node \
		bundler \
	&& gem install \
		jekyll \
		jekyll-pandoc \
	&& install2.r --error --repos='http://yihui.name/xran' servr

WORKDIR /data
EXPOSE 4321
USER docker 


## Assumes Jekyll source-files are in _site-source
CMD Rscript -e 'servr::jekyll(dir = "_site-source", host = "0.0.0.0")' && mv _site-source/_site/* ./
