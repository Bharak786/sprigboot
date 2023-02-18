FROM openjdk:11-jdk-slim

RUN apt-get update \
  && dpkg --add-architecture arm64 \
  && apt-get install -y --no-install-recommends procps gdb git curl inotify-tools \
  && apt-get purge -y --auto-remove \
  && apt-get install -y curl \
  && apt-get install -y net-tools \
  && apt-get install -y telnet \ 
  && rm -rf /var/lib/apt/lists/*
  
WORKDIR /app/  

COPY src /app/src

COPY --from=openjdk:${JAVA_VERSION}-jdk /usr/local/openjdk-${JAVA_VERSION} /app/openjdk
   
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
