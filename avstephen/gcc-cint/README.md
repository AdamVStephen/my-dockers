# avstephen/gcc-cint

This is a Docker hub image which has an installation of gcc and a  now obsolete C interpreter tool called cint.

cint was used between 2009 and 2019 within the MARTe project to generate C++ code for introspection.   This tool has been
replaced by an llvm based code generator written by Damien Karkinsky.

See also the [docker hub image](http://hub.docker.com/avstephen/gcc-cint "Docker hub avstephen/gcc-cint")

## TODO

Provide better links to the above tools

1. MARTe
1. cint
1. llvm tool

docker buildx build -t avstephen/gcc-cint:buster-20231030-slim -f Dockerfile .
