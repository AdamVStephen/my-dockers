#!/usr/bin/env bash
# docker buildx build -t avstephen/gcc-cint:buster-20231030-slim -f Dockerfile .

docker buildx build -t avstephen/marte1-toomanych:buster-20231030-slim -f Dockerfile --build-arg CACHEBUST=$(date +%s) .
