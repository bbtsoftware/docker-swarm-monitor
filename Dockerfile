FROM nginx:1.21.0-alpine
LABEL MAINTAINER="BBT Software AG <opensource@bbtsoftware.ch>"

ENV CHK_DOCKER_API_VERSION v1.38
ENV CHK_INTERVAL 60
ENV CHK_MONITOR prtg
ENV CHK_SERVICES sample.1

ENV TZ UTC

COPY index.html /usr/share/nginx/html/index.html

RUN apk add --no-cache bash curl jq && \
    echo $TZ > /etc/timezone

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80

HEALTHCHECK --interval=1m --timeout=3s \
    CMD curl -f http://localhost/status.json || exit 1