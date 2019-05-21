FROM nginx:1.16.0-alpine
LABEL MAINTAINER = 'BBT Software AG <devadmin@bbtsoftware.ch>'

ENV VERSION 1.0.0

ENV CHK_URL monitor.tempuri.org
ENV CHK_DOCKER_API_VERSION v1.38
ENV CHK_INTERVAL 60
ENV CHK_MONITOR prtg
ENV CHK_SERVICES sample.1

ENV TZ UTC

COPY ./entrypoint.sh /entrypoint.sh
COPY ./index.html /usr/share/nginx/html/index.html

RUN apk add --no-cache bash curl jq && \
  echo $TZ > /etc/timezone

EXPOSE 80

ENTRYPOINT ["bash","/entrypoint.sh"]