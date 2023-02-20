ARG JAVA_VERSION

FROM openjdk:${JAVA_VERSION}

RUN apt-get update && apt-get install -y apt-utils

RUN dpkg --add-architecture arm64 \   
  && apt-get install -y curl \
  && apt-get install -y net-tools \
  && apt-get install -y telnet \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY src /app/src

COPY --from=openjdk:11-jdk /usr/local/openjdk-11  /app/openjdk

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
