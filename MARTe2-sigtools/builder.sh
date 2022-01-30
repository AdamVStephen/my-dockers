#!/usr/bin/env bash
#
# Latch the build commands to ensure reproducibility.

usage() {
	echo "usage"
}

buildit() {
#time docker build -t avstephen/marte2-sigtools-centos7:codename -f Dockerfile.centos7 . 2>&1 | tee build.sigtools.centos7.codename.N
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:airdrie -f Dockerfile.ubuntu-18.04 . 2>&1 | tee build.sigtools.ubuntu-18.04.airdrie.1
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:airdrie -f Dockerfile.ubuntu-18.04 . 2>&1 | tee build.sigtools.ubuntu-18.04.airdrie.1
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:airdrie -f Dockerfile.ubuntu-18.04 . 2>&1 | tee build.sigtools.ubuntu-18.04.airdrie.2
time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.1
time docker build -t avstephen/marte2-sigtools-debian-11:arbroath -f Dockerfile.debian.minimised . 2>&1 | tee build.sigtools.debian.arbroath.1
}

build_tests() {
#time docker build -t avstephen/ephemeral-test -f Dockerfile.dateutils.test . 2>&1 | tee build.ephemeral.test.2
#time docker build -t avstephen/ephemeral-test -f Dockerfile.dateutils.integrated.test . 2>&1 | tee build.dateutils.integrated.test.1
echo "syntax !"
}

buildit
