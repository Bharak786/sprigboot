FROM tomcat:8.0-alpine
LABEL maintainer="umar"
WORKDIR /usr/local/tomcat/webapps/
RUN apk add openjdk8
ADD target/devOps-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
