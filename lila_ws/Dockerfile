FROM phorcys420/lila_base

SHELL ["/bin/bash", "-c"]

RUN git clone --recursive https://github.com/ornicar/lila-ws.git

WORKDIR /home/lichess/lila-ws
ENTRYPOINT ["sbt", "run", "-Dconfig.file=/data/conf.conf"]
