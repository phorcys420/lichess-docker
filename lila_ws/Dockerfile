FROM phorcys/lila_base

SHELL ["/bin/bash", "-c"]

RUN git clone --recursive https://github.com/ornicar/lila-ws.git

WORKDIR /home/lichess/lila-ws

#RUN sbt compile

ENTRYPOINT ["sbt", "run", "-Dconfig.file=/data/conf.conf"]
