# Lichess Docker Container

## Usage

1. Clone or download this repo and `cd` into it
2. Build the image: `docker build --tag lichess .`
3. Clone or downlod [lila](https://github.com/ornicar/lila) and [lila-ws](https://github.com/ornicar/lila-ws). It's assumed they are placed in `$HOME/dev/lichess/{lila,lila-ws}`. If that's not the case you'll have to modify `docker-run.sh` or the command below.
4. Create and start the container:

Either run `./docker-run.sh` or the following command (make sure to adjust `$HOME/dev/lichess` if you cloned lila and lila-ws to a different directory):
```
docker run \
    --mount type=bind,source=$HOME/dev/lichess,target=/home/lichess/projects \
    --publish 9663:9663 \
    --publish 9664:9664 \
    --publish 8212:8212 \
    --name lichess \
    --interactive \
    --tty \
    brandone211/lichess
```

If you are starting the container directly from Windows, you can use `docker-run.bat` instead (again, make sure to adjust the mount point to the actual directory where lila and lila-ws are located). However, I strongly recommend running Docker from WSL 2 and placing lila and lila-ws in the WSL 2 file system since that will significantly speed up compilation.

5. The contianer will automatically start redis and mongo but won't build or run any lila services, so you will have to do that manually. I generally create two additional sessions using `docker exec -it lichess bash` in new terminal windows:
    - One to run `lila-ws` using `cd ~/projects/lila-ws` and `sbt run`.
    - And another to build ui stuff (`cd ~/projects/lila/ui` and `./build` or `./build dev css` or `cd analyse; yarn run dev`, etc.) and other miscellaneous stuff like accessing the db (`mongo lichess`).
    - And ofc, the main session will be used to run lila itself using `./lila run`. On the first run, you should also run `mongo lichess bin/mongodb/indexes.js` to create db indices.
    - Also see [Lichess Development Onboarding guide](https://github.com/ornicar/lila/wiki/Lichess-Development-Onboarding#installation) on the [Lichess GitHub wiki](https://github.com/ornicar/lila/wiki) for additional instructions on seeding the db, gaining admin access, or running suplementary services like fishnet for server analysis or playing vs Stockfish

Note, that with the run command above (or `docker-run.sh`) or the start command below, the container will be stopped (but not deleted) when the main session exits, so that session always has to be kept alive and ideally should be terminated last.

# Useful commands

* Stop the Docker container: `docker stop lichess`
* Restart the Docker container and attach to it: `docker start lichess --attach --interactive`
* Open a second shell in the running container: `docker exec -it lichess bash`
* Remove the Docker container (e.g. to mount a different volume): `docker rm lichess`