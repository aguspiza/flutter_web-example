FROM ubuntu:bionic

ARG flutter_version

ENV FLUTTER_HOME /opt/sdks/flutter
ENV FLUTTER_ROOT $FLUTTER_HOME
ENV FLUTTER_VERSION v1.6.7
ENV ENABLE_FLUTTER_DESKTOP true

RUN apt update -y
RUN apt install -y git

RUN git clone --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN apt install -y curl unzip lib32stdc++6
# for desktop linux
RUN flutter channel beta
RUN flutter precache --linux

# for webdev
EXPOSE 8080
RUN flutter pub global activate flutter_web

# doctor
RUN flutter doctor

# fix persmissions problems
RUN chmod 777 -R $FLUTTER_HOME