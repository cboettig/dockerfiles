# Drone dockerfile. Adapted from mattgruter
# License: MIT

# Quickstart: 
#     docker run -p 8080:80 --privileged mattgruter/drone
# And point your browser to http://localhost:8080/install.

# Adapted from Matthias Grüter <matthias@grueter.name>

## README
# Doubledocker: Docker in Docker
# run [Docker](http://docker.io/) inside Docker
# Permissions: This image needs privileged permissions. Don't forget to use the `--privileged` command line flag.
# Volumes: The AUFS filesystem at `/var/lib/docker` cannot sit ontop of another AUFS filesystem. The directory is therefore exported as a container volume. 
# Ports: the Docker daemon listens on the default socket and on port 2375.
# Example: To run the doubledocker container simply write:    
#    docker run --privileged -P mattgruter/doubledocker
# Use Cases: Running the [Drone CI](http://drone.io/) server inside a [container](https://registry.hub.docker.com/u/mattgruter/drone/).
# Known Issues: Attempting to connect to the docker daemon from the outside fails: 
#    Get http://localhost:49153/v1.12/containers/json: net/http: transport closed before response was received

FROM debian:testing 
MAINTAINER Carl Boettiger <cboettig@ropensci.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    htop \
    wget
RUN curl -s https://get.docker.io/ubuntu/ | sh
RUN echo 'DOCKER_OPTS="-H :2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
VOLUME /var/lib/docker
EXPOSE 2375

## CMD /etc/init.d/docker start && sleep 1 && tail -F /var/log/upstart/docker.log
##### drone Dockerfile setup #########################3
# Adapted FROM mattgruter/doubledocker

RUN wget http://downloads.drone.io/latest/drone.deb \
  && dpkg -i drone.deb \
  && rm drone.deb

EXPOSE 80

VOLUME /var/lib/drone

CMD /etc/init.d/docker start && /usr/local/bin/droned --port=:80 --datasource=/var/lib/drone/drone.sqlite
