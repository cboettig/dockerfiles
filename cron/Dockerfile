# docker run -d -v $(pwd)/crontab:/etc/cron.d/crontab cboettig/cron

FROM ubuntu:14.04
RUN touch /var/log/cron.log
CMD cron && tail -f /var/log/cron.log
