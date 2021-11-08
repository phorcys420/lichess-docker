# Lichess Docker Container

This `docker-compose` project aims to be a realiable and fast way to spin up a `lichess` dev instance.

## Requirements
- [`docker`](https://docs.docker.com/engine/install/) and [`docker-compose`](https://docs.docker.com/compose/install/)
- time, and preferably a coffee machine (or actually, weed)

## Description
- `lila_base` : A docker image based on `debian:buster-20210816-slim` that packages Scala, Java & NodeJS, soon enough to be alpine-based.
- `lila`      : A docker image containing the [lila](https://github.com/ornicar/lila) server. (based on `lila_base`)
- `lila_ws`   : A docker image containing the [lila-ws](https://github.com/ornicar/lila-ws) server. (based on `lila_base`)
- `lila_db`   : A docker image based on `mongo:4.0`, that automatically sets up the database schema for you.

Example nginx configs are also avaible in the [`nginx_examples`](https://github.com/phorcys420/lichess-docker/tree/master/nginx_examples) folder.

## Usage

**Note: One may be tempted to replace the `mongodb://db` and `redis://redis` URLs with whatever their mind comes up with, but this is normal !
Linked docker containers will automatically have hostnames.**

**Note: If you're on windows (non-WSL), make sure your `git` config is using Unix line endings (LF) and not Windows ones (CLRF)**

1. Clone or download this repo and `cd` into it
2. Build the lila_base image using `docker build -t phorcys/lila_base --build-arg TZ=Europe/Paris --build-arg LC=fr_FR.UTF-8 .`
3. Edit the configuration file located at `lila/data/application.conf`
4. Edit the CSRF origin in the config file located at `lila_ws/data/conf.conf`
5. Run `docker-compose up -d --build` from the main directory

## Domain structure
```
chess.lightcord.org.	1	IN	A       78.198.182.162
chess.lightcord.org.	1	IN	AAAA	2a01:e34:ec6b:6a20:7c67:ea98:c5dc:b648
ws.chess.lightcord.org. 1	IN	CNAME   chess.lightcord.org.
```

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
* Add fishnet
* Add "play against the computer"
* Make `lila_base` alpine-based
* Maybe find a better name
