# Lichess Docker Container

This `docker-compose` project aims to be a reliable and fast way to spin up a `lichess` dev instance.

## Requirements
- [`docker`](https://docs.docker.com/engine/install/) and [`docker-compose`](https://docs.docker.com/compose/install/)
- time, and preferably a coffee machine (or actually, weed)

## Description
- `lila_base` : A docker image based on [`debian`](https://hub.docker.com/_/debian)`:buster-20210816-slim` that packages Scala, Java & NodeJS, soon enough to be alpine-based.
- `lila`      : A docker image containing the [lila](https://github.com/ornicar/lila) server. (based on `lila_base`)
- `lila_ws`   : A docker image containing the [lila-ws](https://github.com/ornicar/lila-ws) server. (based on `lila_base`)
- `lila_db`   : A docker image based on [`mongo`](https://hub.docker.com/_/mongo)`:4.0`, that automatically sets up the database schema for you.

An example nginx config is also avaible in the [`nginx_examples`](https://github.com/phorcys420/lichess-docker/tree/master/nginx_examples) folder.

## Usage

**Note: One may be tempted to replace the `mongodb://db` and `redis://redis` URLs with whatever their mind comes up with, but this is normal !
Linked docker containers will automatically have hostnames.**

**Note: If you're on windows (non-WSL), make sure your `git` config is using Unix line endings (LF) and not Windows ones (CLRF).**

<br/>

1. Clone or download this repo and `cd` into it
2. Build the lila_base image using `docker build -t phorcys420/lila_base lila_base/`
3. Edit the example configuration file located at `lila/data/application.conf.example` and rename it to `application.conf`
4. Edit the CSRF origin in the example config file located at `lila_ws/data/conf.conf.example` and rename it to `conf.conf`
5. Run `docker-compose up -d --build` from the main directory

<p align="center">OR</p>

1. Run
```sh
curl -o- https://raw.githubusercontent.com/phorcys420/lichess-docker/install-script/setup.sh | bash
```
2. Edit the configuration file located at `lila/data/application.conf`
3. Edit the CSRF origin in the config file located at `lila_ws/data/conf.conf`
4. Run `docker-compose up -d` from the main directory

## Domain structure
```
chess.lightcord.org.	1	IN	A       78.198.182.162
chess.lightcord.org.	1	IN	AAAA	2a01:e34:ec6b:6a20:7c67:ea98:c5dc:b648
lichess.lightcord.org.  1       IN      CNAME   chess.lightcord.org.
ws.chess.lightcord.org. 1	IN	CNAME   chess.lightcord.org.
```

Nginx [config](https://github.com/phorcys420/lichess-docker/tree/master/nginx_examples) description :
`chess.lightcord.org` being the main domain.
`lichess.lightcord.org` being a redirect (301) to `chess.lightcord.org`.
`ws.chess.lightcord.org` being the websocket server for `chess.lightcord.org`.

## Useful commands

* Stop all the Compose containers: `docker-compose down`
* Start all the Compose containers: `docker-compose up -d`
* Remove all the stopped Compose containers: `docker-compose rm`
* Start all the Compose containers and build the modified images: `docker-compose up -d --build`


* View container logs: `docker logs lila`
* Stop the Docker container: `docker stop lila`
* Open a shell in the running container: `docker exec -it lila bash`
* Attach to the Docker container (main process): `docker attach lila`
* Open a shell as root in the running container: `docker exec -u 0 -it lila bash`

In the above commands, `lila` is replaceable by `lila_ws`, `lila_db` and any container name in that manner.

## TODO
* Get the `lila` Dockerfile to minify on git clone.
* Get the `lichobile` container to serve lichobile.
* Add fishnet.
* Add "play against the computer"
* Make `lila_base` alpine-based
* Maybe find a better name
