FROM openjdk:11-jdk-slim

ARG JAVA_VERSION

RUN apt-get update \
  && dpkg --add-architecture arm64 \
  && apt-get install -y curl \
  && apt-get install -y net-tools \
  && apt-get install -y telnet \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY src /app/src

RUN cat additional_bash_commands.sh >> ~/.bashrc

COPY --from=openjdk:${JAVA_VERSION}-jdk /usr/local/openjdk-${JAVA_VERSION}  /app/openjdk

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
