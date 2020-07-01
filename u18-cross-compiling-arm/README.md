# Qemu Raspberry Pi

The Dockerfile takes an Ubuntu 18.04 base and installs gcc-7 cross compilation tools for the arm64 architecture.
In addition, it adds the qemu emulator for this platform.

A kernel and root file system based on a Debian buster lite Raspbian image are copied into the container, following
instructions based on https://github.com/dhruvvyas90/qemu-rpi-kernel which provides the kernel and device tree blob
as well as the relevant qemu invocation to spin up a raspberry pi emulator.

## Getting Started

To run a raspberry pi arm system under qemu :

1. docker run -it avstephen/u18-cross-compiling-arm:latest bash
2. unzip 2020-05-27-raspios-buster-lite-armhf.zip
3. ./run-qemu.sh

Be patient - it may take tens of seconds for the raspberry pi to spin up.   You can log in as "pi", password "raspberry".

Note the raspbian image is shipped as a zip file to keep the docker container light for docker pull.  If you use
this feature, then docker commit locally on a running container to create your own persistent uncompressed .img.

## Arm64 Cross Compiler Features

The arm64 cross compiler is in /usr/bin/aarch64-linux-gnu-gcc-7

This can be used to cross compile the hello world C source for arm64.

To run it on the pi, use the variant run-qemu-mount.sh script which makes available a shared directory that can be
mounted as follows :

1. sudo su
2. mkdir -p /tmp/shared
3. mount -t 9p -o trans=virtio shared_mount /tmp/shared

This demonstrates that a 64 bit arm binary won't run on a 32 bit arm1176 CPU, because I forgot to check when I
saw that qemu-system-aarch64 had support for the raspberry pi 2 platform whether the pi2 was 32 or 64 bit.

Next iteration will fix this.

To quit out of qemu in the container, the simplest solution is "shutdown -h now" as root in the guest qemu pi.

## Arm64 Qemu Supported Guests

Run qemu-system-aarch64 -M help
