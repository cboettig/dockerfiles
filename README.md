## Dockerfiles

- Author: Carl Boettiger
- License: MIT

------------

Mock-up bash script to provision a server with commonly used services

NOTE:  Assumes root privileges

Allocate swap space (Useful if node has limited ram)

    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile

Install docker:
    curl -sSL https://get.docker.io/ubuntu/ | sudo sh


Deploy RStudio on 8787 (with rich R environment installed)

    docker run --name='rstudio' -d -p 8787:8787 cboettig/ropensci

Install nsenter:

    docker run -v /usr/local/bin:/target jpetazzo/nsenter

Configure users: log into image using nsenter:

   nsenter -m -u -n -i -p -t `docker inspect --format '{{ .State.Pid }}' rstudio` /bin/bash

then configure users and passwords (including default user):

```
useradd -m $USER && echo "$USER:$PASSWORD" | chpasswd
```

Finally, give users ownership over their own home directory

    chown -R $USER:$USER /home/$USER


Deploy Drone CI on 8080 (Then visit localhost:8080/install)

    docker run --name='drone' -d -p 8080:80 --privileged mattgruter/drone


Deploy Gitlab on 10080

    docker run --name='gitlab' -d \
      -p 10022:22 -p 10080:80 \
      -e 'GITLAB_PORT=10080' -e 'GITLAB_SSH_PORT=10022' \
      sameersbn/gitlab:7.2.1-1

Visit http://localhost:10080 and login using the default username and password: root/5iveL!fe. Deploy RStudio's shiny-server on 3838

    docker run -d -p 3838:3838 cboettig/shiny

Deploy OpenCPU (on 443?)

    docker run -t -d -p 5080:8006 -p 443:8007 jeroenooms/opencpu-dev

