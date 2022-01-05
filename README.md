# my-dockers
Mix of Dockerfiles and pointers to docker containers I have pushed to hub.docker.com for testing and dev.

## Docker Hub Images

The following images have some practical benefit and are in active use on some of the projects I work with.

1. https://hub.docker.com/repository/docker/avstephen/m2padova
1. https://hub.docker.com/repository/docker/avstephen/bullseye-stm32cube-gcc

## Dockerfile Examples

The following docker examples have not been pushed as images to hub.docker.com as they are simply examples
for verifying particular ways to build and run docker images, and not fully useful images in their own right.

For each, the recipe to explore building and running them (especially with a view to supporting X apps) is as follows.
Assume that MYDOCKER=docker-name in each case.  e.g. MYDOCKER=u18-astephen-x11-apps would work.

'''
cd $MYDOCKER
docker build -t $MYDOCKER .
docker run -it --net=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix -v/home/astephen/.Xauthority:/home/astephen/.Xauthority:rw $MYDOCKER bash
'''

### u18
Basic Ubuntu 18.04 anchor.

###u18-astephen

Adds a vanilla non-root account to Ubuntu 18.04 named astephen.   The idea here is where it may be useful to match uid/gid on a docker host system.

### u18-astephen-x11-apps

Installs firefox and x11-apps to permit testing.

### running-xeyes-u18

Example to run Xeyes taken from online post.
