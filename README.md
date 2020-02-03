# Docker Swarm monitor

Docker image to monitor a [Docker Swarm](https://docs.docker.com/engine/swarm/).

Supported monitoring systems:

* [PRTG Network Monitor](https://www.paessler.com/prtg/)

## Information

| Service | Stats                                                                                     |
|---------|-------------------------------------------------------------------------------------------|
| Docker  | [![Build](https://img.shields.io/docker/cloud/build/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor/builds) [![Pulls](https://img.shields.io/docker/pulls/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor) [![Stars](https://img.shields.io/docker/stars/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor) [![Automated](https://img.shields.io/docker/cloud/automated/bbtsoftwareag/swarm-monitor.svg?style=flat-square)](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor/builds) |
| GitHub  | [![Last commit](https://img.shields.io/github/last-commit/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/commits/master) [![Issues](https://img.shields.io/github/issues-raw/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-warm-monitor/issues) [![PR](https://img.shields.io/github/issues-pr-raw/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/pulls) [![Size](https://img.shields.io/github/repo-size/bbtsoftware/docker-swarm-monitor.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/) [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/bbtsoftware/docker-swarm-monitor/blob/master/LICENSE) |

## General

| Topic  | Description                                                             |
|--------|-------------------------------------------------------------------------|
| Image  | See [Docker Hub](https://hub.docker.com/r/bbtsoftwareag/swarm-monitor). |
| Source | See [GitHub](https://github.com/bbtsoftware/docker-swarm-monitor).      |

## Installation

```sh
docker pull bbtsoftwareag/swarm-monitor
```

### Tags

| Tag    | Description                                                                             | Size                                                                                                                   |
|--------|-----------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| latest | Latest master build                                                                     | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/swarm-monitor/latest.svg?style=flat-square) |
| 1.2.0  | Release [1.2.0](https://github.com/bbtsoftware/docker-swarm-monitor/releases/tag/1.2.0) | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/swarm-monitor/1.2.0.svg?style=flat-square)  |
| 1.1.0  | Release [1.1.0](https://github.com/bbtsoftware/docker-swarm-monitor/releases/tag/1.1.0) | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/swarm-monitor/1.1.0.svg?style=flat-square)  |
| 1.0.0  | Release [1.0.0](https://github.com/bbtsoftware/docker-swarm-monitor/releases/tag/1.0.0) | ![Size](https://shields.beevelop.com/docker/image/image-size/bbtsoftwareag/swarm-monitor/1.0.0.svg?style=flat-square)  |

### Volumes

| Directory            | Description                                                         |
|----------------------|---------------------------------------------------------------------|
| /var/run/docker.sock | `docker.sock` needs to be mounted to be able to check the services. |

### Ports

| Port | Protocol | Description                          |
|------|----------|--------------------------------------|
| 8080 | TCP      | Web-UI which provides `status.json`. |

### Configuration

These environment variables are supported:

| ENV field              | Example values        | Description                                                                                                                       |
|------------------------|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| DOCKER_GID             | `1101`                | ID of the group running the Docker daemon on the host, typically ID of the `docker` group. Default is `1101`.                     |
| TZ                     | `Europe/Zurich`       | Timezone to set.                                                                                                                  |
| CHK_DOCKER_API_VERSION | `v1.38`               | Docker API version to use. Default is `v1.38`.                                                                                    |
| CHK_INTERVAL           | `60`                  | Interval for check in seconds. Default is `60`.                                                                                   |
| CHK_MONITOR            | `prtg`                | Used monitoring. Defines the format of the `status.json`. Currently supported is `prtg`.                                          |
| CHK_SERVICES           | `proxy_app.3`         | Services to monitor. Format is `stack_service.expected-amount-of-instances`. Multiple services can be defined separated by space. |

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
      - 80:8080
    environment:
      - TZ=Europe/Zurich
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
  -p 80:8080 \
  -e TZ=Europe/Zurich \
  -e CHK_DOCKER_API_VERSION=v1.38 \
  -e CHK_INTERVAL=60 \
  -e CHK_MONITOR=prtg \
  -e "CHK_SERVICES=monitor_app.1 proxy_app.3" \
  bbtsoftwareag/swarm-monitor:latest
```
