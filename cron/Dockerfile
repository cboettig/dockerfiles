# docker run -d -v $(pwd)/crontab:/etc/cron.d/crontab cboettig/cron

FROM ubuntu:14.04
## Install any software required by crontab commands:
RUN apt-get update && apt-get -y install curl
RUN touch /var/log/cron.log
CMD cron && tail -f /var/log/cron.log
