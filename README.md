# Docker Swarm monitor

This Docker image allows to monitor a [Docker Swarm](https://docs.docker.com/engine/swarm/).

## Information

| Service | Stats                                                                                     |
|---------|-------------------------------------------------------------------------------------------|
| Docker  | [![Build](https://img.shields.io/docker/cloud/build/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor/builds) [![Pulls](https://img.shields.io/docker/pulls/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor) [![Stars](https://img.shields.io/docker/stars/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor) [![Automated](https://img.shields.io/docker/cloud/automated/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftware/docker-swarm/builds) |
| GitHub  | [![Last commit](https://img.shields.io/github/last-commit/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/commits/master) [![Issues](https://img.shields.io/github/issues-raw/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-warm-monitor/issues) [![PR](https://img.shields.io/github/issues-pr-raw/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/pulls) [![Size](https://img.shields.io/github/repo-size/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/) [![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/bbtsoftware/docker-swarm-monitor/blob/master/LICENSE) |

## General

| Topic  | Description                                                             |
|--------|-------------------------------------------------------------------------|
| Image  | See [Docker Hub](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor). |
| Source | See [GitHub](https://github.com/bbtsoftware/docker-swarm-monitor).      |

## Installation

```sh
docker pull bbtsoftwareag/swarm-monitor
```

### Supported tags

| Tag    | Description                                                                             | Size                                                                                                                   |
|--------|-----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| latest | Latest master build                                                                     | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/swarm-monitor/latest.svg?style=flat-square) |
| 1.0.0  | Release [1.0.0](https://github.com/bbtsoftware/docker-swarm-monitor/releases/tag/1.0.0) | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/swarm-monitor/1.0.0.svg?style=flat-square)  |

### Volumes

| Directory            | Description                                                         |
|----------------------|---------------------------------------------------------------------|
| /var/run/docker.sock | `docker.sock` needs to be mounted to be able to check the services. |

### Exposed Ports

| Port | Protocol | Description                          |
|------|----------|--------------------------------------|
|   80 | TCP      | Web-UI which provides `status.json`. |

### Configuration

These environment variables must be set for the first start:

| ENV field              | Values                | Description                                                                                                    |
|------------------------|-----------------------|----------------------------------------------------------------------------------------------------------------|
| TZ                     | `Europe/Zurich`       | Timezone to set.                                                                                               |
| CHK_URL                | `monitor.tempuri.org` | Base url to use for nginx redirect to `status.json`.                                                           |
| CHK_DOCKER_API_VERSION | `v1.38`               | Docker API version to use.                                                                                     |
| CHK_INTERVAL           | `60`                  | Interval for check in seconds.                                                                                 |
| CHK_MONITOR            | `prtg`                | Used monitor, this defines the format of the `status.json`.                                                    |
| CHK_SERVICES           | `proxy_app.3`         | Services to monitor. Format is `stack_service.expected-amount-of-instances`. Multiple services can be defined. |

## Samples

### docker-compose

```yaml
version: '3.7'

services:
  app:
    image: bbtsoftwareag/swarm-monitor:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 80:80
    environment:
      - TZ=Europe/Zurich
      - CHK_URL=monitor.tempuri.org
      - CHK_DOCKER_API_VERSION=v1.38
      - CHK_INTERVAL=60
      - CHK_MONITOR=prtg
      - "CHK_SERVICES=
          monitor_app.1
          proxy_app.3"
    networks:
      - default
```

### docker run

```sh
docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -p 80:80 \
  -e TZ=Europe/Zurich \
  -e CHK_URL=monitor.tempuri.org \
  -e CHK_DOCKER_API_VERSION=v1.38 \
  -e CHK_INTERVAL=60 \
  -e CHK_MONITOR=prtg \
  -e "CHK_SERVICES=monitor_app.1 proxy_app.3" \
  bbtsoftwareag/swarm-monitor:latest
```