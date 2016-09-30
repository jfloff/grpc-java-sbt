# grpc-java-sbt

Runs a basic gRPC `hello-world` Java example ported from [Google's repository](https://github.com/grpc/grpc-java/tree/master/examples) using SBT build tool, instead of Gradle or Maven (the ones Google's official repository gives support), leveraged on `sbt-protobuf` plugin.


## More infomation

Please refer to the following links for more information:

* gRPC protocol at www.grpc.io and its [java tutorial](http://www.grpc.io/docs/tutorials/basic/java.html)];
* gRPC Java's and its plugin at [grpc/grpc-java`](https://github.com/grpc/grpc-java);
* Google's Protocol Buffers at [google/protobuf](https://github.com/google/protobuf);
* SBT `protobuf` plugin at [sbt-protobuf](https://github.com/sbt/sbt-protobuf).


## Requirements

* `grpc-java` plugin built. I recommend you to build it from source (downloading from [Maven Central](http://search.maven.org/#search%7Cga%7C1%7Ca%3A%22protoc-gen-grpc-java%22) is also a possibility if compatible with your OS). You can find build instructions at the [grpc-java](https://github.com/grpc/grpc-java/tree/master/compiler);
* `protobuf` compiler available (version `3.0.0` or up). You can find more information at [google/protobuf](https://github.com/google/protobuf);
* `sbt` to build the project

Check the repo's [Dockerfile](Dockerfile) for some hints on how to setup your system. More info on the Docker image below.


## Settings

Update [`build.sbt`](build.sbt#L24) replacing the following values:

* `PATH_PROTOC` with the path for your `protoc` bin;
* `PATH_GRPC_JAVA_PLUGIN` with the path for the `protoc-gen-grpc-java` gRPC Java's protobuf plugin.


## Run

In one terminal run `sbt run` and select the `hello-world-server` main to spawn a server. In another terminal run `sbt run` again and select `hello-world-client` main to spawn a client (you can spawn multiple clients by repeating this step).

That's it!


## Docker

I'm also providing a Dockerfile that builds an image that pre-builds all the listed requirements, and runs the example.

* To build the image just run: `docker build --rm -t jfloff/grpc-java-sbt .`
* Run the image with: `docker run -it --name grpc-java-sbt jfloff/grpc-java-sbt`
* And for a 2nd terminal run: `docker exec -ti grpc-java-sbt run sbt`
