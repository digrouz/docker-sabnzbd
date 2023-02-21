[![auto-update](https://github.com/digrouz/docker-sabnzbd/actions/workflows/auto-update.yml/badge.svg)](https://github.com/digrouz/docker-sabnzbd/actions/workflows/auto-update.yml)
[![dockerhub](https://github.com/digrouz/docker-sabnzbd/actions/workflows/dockerhub.yml/badge.svg)](https://github.com/digrouz/docker-sabnzbd/actions/workflows/dockerhub.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/digrouz/sabnzbd)

# docker-sabnzbd

Install sabnzbd into an Alpine container

![sabnzbd](https://avatars1.githubusercontent.com/u/960698?v=3&s=200)

## Tag
Several tag are available:
* latest: see alpine
* alpine: [Dockerfile_alpine](https://github.com/digrouz/docker-sabnzbd/blob/master/Dockerfile_alpine)
* Any version specific tag is based on alpine.

## Description
SABnzbd makes Usenet as simple and streamlined as possible by automating everything we can. All you have to do is add an .nzb. SABnzbd takes over from there, where it will be automatically downloaded, verified, repaired, extracted and filed away with zero human interaction.

http://sabnzbd.org/

## Usage
    docker create --name=sabnzbd \
        -v <path to data>:/config \
        -v <path to downloads>:/downloads \
        -v <path to incomplete downloads>:/incomplete-downloads \
        -e UID=<UID default:12345> \
        -e GID=<GID default:12345> \
        -e AUTOUPGRADE=<0|1 default:0> \
        -e TZ=<timezone default:Europe/Brussels> \
        -p 8080:8080 \
        -p 9090:9090  \
    digrouz/sabnzbd
        
## Environment Variables

When you start the `sabnzbd` image, you can adjust the configuration of the `sabnzbd` instance by passing one or more environment variables on the `docker run` command line.

### `UID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `12345`.

### `GID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `12345`.

### `AUTOUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

### `TZ`

This variable is not mandatory and specifies the timezone to be configured within the container. It has default value `Europe/Brussels`.

## Notes

* This container is built using [s6-overlay](https://github.com/just-containers/s6-overlay)
* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e AUTOUPGRADE=1` at container creation.

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-sabnzbd/issues)


