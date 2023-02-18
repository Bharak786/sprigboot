FROM arm64v8/ubuntu:18.04

ENV JAVA_VERSION 11.0.1

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L -o openjdk.tar.gz https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.1%2B13/OpenJDK11U-aarch64_linux_hotspot_11.0.1_13.tar.gz && \
    mkdir -p /usr/local/openjdk-${JAVA_VERSION} && \
    tar -zxvf openjdk.tar.gz -C /usr/local/openjdk-${JAVA_VERSION} --strip-components=1 && \
    rm openjdk.tar.gz

ENV PATH="/usr/local/openjdk-${JAVA_VERSION}/bin:${PATH}"
