FROM rocker/hadleyverse 
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Install ruby & javascript environment, servr R package
RUN apt-get update && apt-get -y install \
		node \
		bundler \
    ruby-dev \
	&& install2.r --error --repos='http://yihui.name/xran' servr

## Install all gems listed in the Gemfile
COPY Gemfile /data/Gemfile
USER docker
WORKDIR /data
RUN bundle install 

# Expose port and run knitr+jekyll on the site
EXPOSE 4321
CMD Rscript -e 'servr::jekyll(dir = "_site-source/", host = "0.0.0.0")'
