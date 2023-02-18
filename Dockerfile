FROM python:3.8-slim-buster

# Install required packages
RUN apt-get update \
  && dpkg --add-architecture arm64 \
  && apt-get install -y --no-install-recommends procps gdb git curl inotify-tools \
  && apt-get install -y gcc python3-dev \
  && apt-get purge -y --auto-remove \
  && apt-get install -y curl \
  && apt-get install -y net-tools \
  && apt-get install -y telnet \
  && rm -rf /var/lib/apt/lists/*

# Set the Java version as a build argument
ARG JAVA_VERSION

WORKDIR /app/

COPY src /app/src

# Install OpenJDK
RUN curl -L -o /tmp/openjdk.tar.gz https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.1%2B13/OpenJDK11U-aarch64_linux_hotspot_11.0.1_13.tar.gz | gzip -dc > /tmp/openjdk.tar.gz
  && mkdir -p /usr/local/openjdk-${JAVA_VERSION} \
  && tar -zxvf /tmp/openjdk.tar.gz -C /usr/local/openjdk-${JAVA_VERSION} --strip-components=1 \
  && rm /tmp/openjdk.tar.gz

ENV PATH="/usr/local/openjdk-${JAVA_VERSION}/bin:${PATH}"

CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
