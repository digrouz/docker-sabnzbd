# docker-alp-sabnzbd

Install sabnzbd into an Alpine container

![sabnzbd](https://avatars1.githubusercontent.com/u/960698?v=3&s=200)

## Description
SABnzbd makes Usenet as simple and streamlined as possible by automating everything we can. All you have to do is add an .nzb. SABnzbd takes over from there, where it will be automatically downloaded, verified, repaired, extracted and filed away with zero human interaction.

http://sabnzbd.org/

## Usage
    docker create --name=sabnzbd \
        -v <path to data>:/config \
        -v <path to downloads>:/downloads \
        -v <path to incomplete downloads>:/incomplete-downloads \
        -v /etc/localtime:/etc/localtime:ro \
        -e DOCKUID=<UID default:10012> \
        -e DOCKGID=<GID default:10012> \
        -p 8080:8080 \
        -p 9090:9090   digrouz/docker-alp-sabnzbd
        
## Environment Variables

When you start the `sabnzbd` image, you can adjust the configuration of the `sabnzbd` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKUID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `10012`.

### `DOCKGID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `10012`.
