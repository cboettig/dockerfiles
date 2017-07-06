
## socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
## open -a XQuartz
## docker build -t pithos .
## docker run -e DISPLAY=192.168.1.5:0 --rm -ti pithos

FROM ubuntu:latest

RUN apt-get update && apt-get -y install software-properties-common \
  && add-apt-repository ppa:pithos/ppa \
  && apt-get update \
  && apt-get install --install-recommends -y pithos

CMD pithos
