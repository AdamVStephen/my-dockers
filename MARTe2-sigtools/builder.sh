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
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.1
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.2
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.3
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.4
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.5
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.6
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.7
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.8
# Repeat after adding the set -u guard and fixing typo.
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.9
# Add more cache protection and defend set -u against LD_LIBRARY_PATH being bull
#time docker build --build-arg CACHE_DATE="$(date)" -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.10
#time docker build --build-arg CACHE_DATE="$(date)" -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.11
#time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.12

###time docker build --build-arg CACHE_DATE="$(date)" -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.13

###time docker build -t avstephen/marte2-sigtools-ubuntu-1804:arbroath -f Dockerfile.ubuntu-18.04.minimised . 2>&1 | tee build.sigtools.ubuntu-18.04.arbroath.5
#time docker build -t avstephen/marte2-sigtools-debian-11:arbroath -f Dockerfile.debian.minimised . 2>&1 | tee build.sigtools.debian.arbroath.1
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.1
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.2
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.3
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.4
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.5
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.6
# Add ARG CACHE_DATE because the git cache was screwing the .6 build
# Move the git log -1 command to after the WORKDIR to fix the .7 build.
# Add set -u guards to avoid typos in shell variables (beware the installed file though - it may be cached)
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.8
# Force cache invalidation via --build-arg : this is getting really tedious.
# And a better build script
#time docker build --build-arg CACHE_DATE="$(date)" -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.10
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.10
# Issue in step 14 sourcing the environment script ? 
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.11
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.12
#time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.13
#time docker build --build-arg CACHE_DATE="$(date)" -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.14

###time docker build -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.minimised . 2>&1 | tee build.sigtools.centos7.arbroath.15

}

build_tests() {
#time docker build -t avstephen/ephemeral-test -f Dockerfile.dateutils.test . 2>&1 | tee build.ephemeral.test.2
#time docker build -t avstephen/ephemeral-test -f Dockerfile.dateutils.integrated.test . 2>&1 | tee build.dateutils.integrated.test.1
echo "syntax !"
}

buildit
