FROM nginxinc/nginx-unprivileged:1.17.8-alpine
LABEL MAINTAINER="BBT Software AG <devadmin@bbtsoftware.ch>"

ENV CHK_DOCKER_API_VERSION v1.38
ENV CHK_INTERVAL 60
ENV CHK_MONITOR prtg
ENV CHK_SERVICES sample.1

ENV TZ UTC

COPY index.html /usr/share/nginx/html/index.html

USER root
RUN chmod 775 /usr/share/nginx/html/
RUN chown nginx:nginx /usr/share/nginx/html/
RUN apk add --no-cache bash curl jq && \
    echo $TZ > /etc/timezone
USER nginx

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80

HEALTHCHECK --interval=1m --timeout=3s \
    CMD curl -f http://localhost/status.json || exit 1