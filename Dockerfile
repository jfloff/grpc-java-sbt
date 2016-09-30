# Echo Client-Server with Redis writes on the server side.
FROM openjdk:8

MAINTAINER João Loff <jfloff@gsd.inesc-id.pt>

# Install packages
RUN apt-get update && apt-get install -y \
    build-essential \
  && rm -rf /var/lib/apt/lists/*

# Install SBT
# taken from: https://github.com/hseeberger/scala-sbt/blob/master/Dockerfile
ENV SBT_VERSION 0.13.12
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN curl -#sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar -xz -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

# Install PROTOBUF
# Only works for 3.0.0 and up
ENV PROTOBUF_VERSION 3.0.0
RUN curl -#sL "https://github.com/google/protobuf/releases/download/v$PROTOBUF_VERSION/protobuf-java-$PROTOBUF_VERSION.tar.gz" | tar -xz -C /usr/local \
  && cd /usr/local/protobuf-$PROTOBUF_VERSION && ./configure --prefix=/usr \
  && make && make install \
  && rm -rf /usr/local/protobuf-$PROTOBUF_VERSION

# Compile GRPC JAVA
ENV GRPC_JAVA_VERSION 1.0.1
RUN curl -#sL "https://github.com/grpc/grpc-java/archive/v$GRPC_JAVA_VERSION.tar.gz" | tar -xz -C /usr/local \
  && cd /usr/local/grpc-java-$GRPC_JAVA_VERSION/compiler && ../gradlew java_pluginExecutable \
  && cp ./build/exe/java_plugin/protoc-gen-grpc-java /usr/local/bin/protoc-gen-grpc-java \
  && rm -rf /usr/local/grpc-java-$GRPC_JAVA_VERSION

# add app
ADD . /home/app
WORKDIR /home/app

# bootstrap sbt predownloading bunch of dependencies
RUN sbt update

ENTRYPOINT sbt run
CMD sbt run
