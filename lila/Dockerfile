FROM phorcys/lila_base

SHELL ["/bin/bash", "-c"]

# Compile lila
RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    git clone --recursive https://github.com/ornicar/lila.git && \
    cd lila && \
    ./ui/build && \
    ./lila compile

WORKDIR /home/lichess/lila

RUN unlink /home/lichess/lila/conf/application.conf
RUN ln -s /data/application.conf /home/lichess/lila/conf/application.conf

ENTRYPOINT ["./lila", "run"]
