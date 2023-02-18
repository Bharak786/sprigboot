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
  
WORKDIR /app/  

COPY src /app/src

COPY --from=openjdk:11-jdk /usr/local/openjdk-11 /app/openjdk  
   
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
