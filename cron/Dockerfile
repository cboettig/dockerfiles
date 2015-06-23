FROM ubuntu 14.04
COPY crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log
CMD cron && tail -f /var/log/cron.log
