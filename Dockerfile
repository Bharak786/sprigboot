FROM python:3.8-slim-buster

RUN apt-get update \
  && dpkg --add-architecture arm64 \
  && apt-get install -y --no-install-recommends procps gdb git curl inotify-tools \
  && apt-get install -y gcc python3-dev \
  && apt-get purge -y --auto-remove \
  && apt-get install -y curl \
  && apt-get install -y net-tools \
  && apt-get install -y telnet \ 
  && rm -rf /var/lib/apt/lists/*

ARG JAVA_VERSION

RUN curl -L -O "https://download.java.net/java/GA/jdk${JAVA_VERSION}/GPL/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" \
  && tar -xzf "openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" \
  && mkdir -p /usr/local/openjdk \
  && mv "jdk-${JAVA_VERSION}" /usr/local/openjdk/ \
  && rm "openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz"

ENV PATH /usr/local/openjdk/jdk-${JAVA_VERSION}/bin:$PATH

WORKDIR /app/

COPY src /app/src

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
