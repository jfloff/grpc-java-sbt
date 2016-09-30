import sbtprotobuf.{ProtobufPlugin=>PB}
Seq(PB.protobufSettings: _*)

// Project name (artifact name in Maven)
name := "grcp-java-sbt"

// orgnization name (e.g., the package name of the project)
organization := "io.grpc.examples"

version := "1.0"

// Flags for pure-Java projects
// Do not append Scala versions to the generated artifacts
crossPaths := false
// This forbids including Scala related libraries into the dependency
autoScalaLibrary := false

// project description
description := "Example of grcp-java on sbt"

// library dependencies. (orginization name) % (project name) % (version)
libraryDependencies += "io.grpc" % "grpc-all" % "1.0.1"

// << Update these value according to your configuration >>
// PATH FOR THE protobuf compiler bin
val PATH_PROTOC = "/usr/bin/protoc"
// PATH FOR THE gRPC-Java Protobuf Plugin
// val PATH_GRPC_JAVA_PLUGIN = "/home/grpc-java/compiler/build/exe/java_plugin/protoc-gen-grpc-java"
val PATH_GRPC_JAVA_PLUGIN = "/usr/local/bin/protoc-gen-grpc-java"

// gRPC config
version in PB.protobufConfig := "3.0.0"
protoc in PB.protobufConfig := PATH_PROTOC
sourceDirectory in PB.protobufConfig := baseDirectory.value / "src" / "main" / "proto"
// compileOrder := CompileOrder.JavaThenScala

// Need a grpc plugin to generate grpc service class from .proto file
// more info here: https://github.com/grpc/grpc-java/blob/master/compiler/README.md#compiling-and-testing-the-codegen
protocOptions in PB.protobufConfig ++= Seq(
  "--plugin=protoc-gen-grpc-java=" + PATH_GRPC_JAVA_PLUGIN,
  "--grpc-java_out=" + baseDirectory.value + "/target/src_managed/main/compiled_protobuf"
)
