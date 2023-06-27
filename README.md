# Stunnel Docker images

[Stunnel](https://www.stunnel.org/) is a "proxy designed to add TLS encryption
functionality to existing clients and servers without any changes in the
programs' code".

This Dockerfile allows it to run as a Windows container, in situations where a
Linux container isn't usable, or on Alpine Linux.


## Usage (Windows)

``` sh
cd windows
docker build -t stunnel .
docker run -p <container port>:<local port> -e "STUNNEL_CONF=<configuration>" stunnel
```

## New Versions (windows)

If a [new version of Stunnel](https://www.stunnel.org/NEWS.html) or [new version of Windows](https://hub.docker.com/_/microsoft-windows) is released, update [.github/workflows/build_windows_images.yml](https://github.com/mbta/stunnel-docker/blob/main/.github/workflows/build_windows_images.yml) to include the new versions in the build matrix.

## Usage (Alpine Linux)

``` sh
cd alpine
docker build -t stunnel .
docker run -p <container port>:<local port> -e "STUNNEL_CONF=<configuration>" stunnel
```

## New Versions (Alpine Linux)

If a [new version of Stunnel](https://www.stunnel.org/NEWS.html) or [new version of Alpine Linux](https://alpinelinux.org/releases/) is released, update [.github/workflows/build_alpine_images.yml](https://github.com/mbta/stunnel-docker/blob/main/.github/alpine/build_windows_images.yml) to include the new versions in the build matrix.
