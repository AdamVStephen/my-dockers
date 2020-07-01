FROM ubuntu:18.04

# Required packages for general software development

RUN apt-get update && apt-get install -y git make vim python sudo build-essential cmake unzip

# Add arm64 cross tools

RUN apt-get install -y cpp-aarch64-linux-gnu gcc-7-aarch64-linux-gnu libc-dev-arm64-cross 

# Add qemu full system emulation binaries for arm.

RUN apt-get update && apt-get install -y qemu-system-aarch64	

# Add xcdev as a non-privileged user

RUN adduser --disabled-password --gecos '' xcdev && \
	echo "xcdev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/xcdev && \
	chmod 0440 /etc/sudoers.d/xcdev

# Grant xcdev user sudo privilege to test apt install commands
# CAVEAT : if new packages required, then make an updated Dockerfile to latch these.

RUN usermod -aG sudo xcdev

USER xcdev
ENV HOME /home/xcdev
CMD /bin/bash

WORKDIR /home/xcdev

# Copy buster raspbian light zip file, kernel and dtb into image; 

COPY data/2020-05-27-raspios-buster-lite-armhf.zip data/versatile-pb-buster.dtb data/kernel-qemu-4.19.50-buster data/run-qemu.sh data/run-qemu-mount.sh /home/xcdev/
USER root
RUN chown xcdev:xcdev /home/xcdev/* && chmod 744 /home/xcdev/run-qemu.sh
USER xcdev





