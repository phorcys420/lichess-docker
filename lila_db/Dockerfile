FROM mongo:4.0

SHELL ["/bin/bash", "-c"]

RUN apt update -y && \
    apt install -y curl git && \
    mongod --fork --logpath /var/log/mongod.log --dbpath /data/db && \
    curl https://raw.githubusercontent.com/ornicar/lila/master/bin/mongodb/indexes.js -o indexes.js && \
    mongo lichess indexes.js && \
    git clone https://github.com/ornicar/lila-db-seed && \
    mongorestore lila-db-seed/dump

# Cleanup
RUN rm -r lila-db-seed indexes.js

