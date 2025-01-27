FROM debian:buster-20210816-slim

ARG TZ=GMT0
ARG LC=en_US.UTF-8

SHELL ["/bin/bash", "-c"]

RUN useradd -ms /bin/bash lichess && \
    apt update && \
    apt install -y apt-transport-https apt-utils curl gnupg && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" > /etc/apt/sources.list.d/sbt.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import && \
    chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg && \
    apt update && \
    apt install -y unzip zip parallel git scala sbt openjdk-11-jdk-headless openjdk-11-jre-headless

ENV TZ=$TZ
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Cleanup
RUN apt autoremove -y && \
    apt clean

USER lichess
WORKDIR /home/lichess
ENV HOME /home/lichess

# Silence the parallel citation warning
RUN mkdir -p ~/.parallel && touch ~/.parallel/will-cite

# Set locale
ENV LANG=$LC
ENV LC_ALL=$Lc
ENV LANGUAGE=$LC

# nvm => node => yarn
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 16 && \
    nvm use 16 && \
    npm install -g npm yarn
