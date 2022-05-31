FROM alpine:3.15

RUN apk add curl openjdk11-jre ttf-droid ttf-droid-nonlatin busybox-extras gettext libxml2-utils xmlstarlet
RUN curl -sSL https://github.com/plantuml/plantuml/releases/download/v1.2022.1/plantuml-1.2022.1.jar -o /opt/plantuml.jar
WORKDIR /home
ADD . .
RUN sh build.sh
CMD httpd -p 8080 -h /home/target/static -f -c /home/config/httpd.conf
