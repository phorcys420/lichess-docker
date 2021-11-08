# Lichess Docker Container

This `docker-compose` project aims to be a realiable and fast way to spin up a `lichess` instance.

## Requirements
- `docker` and `docker-compose`
- time, and preferably a coffee machine

## Usage

Note: One may be tempted to replace the `mongodb://db` and `redis://redis` URLs with whatever their mind comes up with, but this is normal !
Linked docker containers will automatically have hostnames.

1. Clone or download this repo and `cd` into it
2. If you're on Windows, make sure all `.sh` files have Unix line endings (i.e. just LF). Depending on your `git` configuration, they might be converted to Windows file endings (i.e. CLRF) which will not work. This may also apply to lila scripts like `./lila` or `./ui/build` later on.
3. Build the lila_base image:
	1. `cd` into the `lila_base` folder
	2. Edit the Dockerfile to match your locale
	3. Run `docker build . -t phorcys/lila_base`
4. Edit the configuration file located in lila/data/application.conf
5. Edit the CSRF origin file located in lila_ws/data/conf.conf
6. Run `docker-compose up -d --build` from the main directory

## Domain structure
```
chess.lightcord.org.	1	IN	A       78.198.182.162
chess.lightcord.org.	1	IN	AAAA	2a01:e34:ec6b:6a20:7c67:ea98:c5dc:b648
ws.chess.lightcord.org. 1	IN	CNAME   chess.lightcord.org.
```

## Useful commands

* Stop the Docker container: `docker stop lila`
* Restart the Docker container and attach to it: `docker start lila --attach --interactive`
* Open a shell in the running container: `docker exec -it lila bash`
* Open a shell as root in the running container: `docker exec -u 0 -it lila bash`
* Remove the Docker container (e.g. to mount a different volume): `docker rm lila`

## TODO
* Add fishnet
* Add "play against the computer"
* Include example nginx configs
