#!/usr/bin/env bash
#
# Latch the build commands to ensure reproducibility.

usage() {
  echo "usage"
}


###
### CENTOS7
###

build_centos7_base() {
  #time docker build --target m2st_base -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.base.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_base -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.base.$(date +%s)
}


build_centos7_packages() {
  #time docker build --target m2st_packages -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.packages.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_packages -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.packages.$(date +%s)
}

build_centos7_dependencies() {
  #time docker build --target m2st_dependencies -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.dependencies.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_dependencies -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.dependencies.$(date +%s)
}

build_centos7_built() {
  #time docker build --target m2st_built -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.built.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_built -t avstephen/marte2-sigtools-centos7:arbroath -f Dockerfile.centos7.multistage . 2>&1 | tee build.sigtools.centos7.arbroath.built.$(date +%s)
}


#build_centos7_base
#build_centos7_packages
#build_centos7_dependencies
#build_centos7_built

###
### UBUNTU-18.04
###

build_ubuntu1804_base() {

  this_log=build.sigtools.ubuntu1804.arbroath.base.$(date +%s)
  #time docker build --target m2st_base -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.base.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_base -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee $this_log
  ln -s $this_log u1804.last.log
}


build_ubuntu1804_packages() {
  #time docker build --target m2st_packages -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.packages.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_packages -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.packages.$(date +%s)
}

build_ubuntu1804_dependencies() {
  #time docker build --target m2st_dependencies -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.dependencies.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_dependencies -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.dependencies.$(date +%s)
}

build_ubuntu1804_built() {
  #time docker build --target m2st_built -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.built.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_built -t avstephen/marte2-sigtools-ubuntu1804:arbroath -f Dockerfile.ubuntu1804.multistage . 2>&1 | tee build.sigtools.ubuntu1804.arbroath.built.$(date +%s)
}


#build_ubuntu1804_base
#build_ubuntu1804_packages
#build_ubuntu1804_dependencies
#build_ubuntu1804_built

###
### DEBIAN-11
###

export DOCKERFILE_DEBIAN11=Dockerfile.debian-11.multistage
export DOCKER_TAG_DEBIAN11=avstephen/marte2-sigtools-debian11:arbroath

build_debian11_base() {
  do_cache=$1
  if [ x"$do_cache" == "xy" ]
  then
    CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
  fi

  this_log=build.sigtools.debian11.arbroath.base.$(date +%s)
  time docker build "${CACHE_OPT:=' '}" \
    --target m2st_base \
    -t ${DOCKER_TAG_DEBIAN11} \
    -f "${DOCKERFILE_DEBIAN11}" . 2>&1 | tee "$this_log"
      #time docker build --build-arg CACHE_DATE="$(date)" --target m2st_base -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee $this_log

      ln -fs $this_log debian11.last.log
    }


  build_debian11_packages() {
    #time docker build --target m2st_packages -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee build.sigtools.debian11.arbroath.packages.$(date +%s)
    time docker build --build-arg CACHE_DATE="$(date)" --target m2st_packages -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee build.sigtools.debian11.arbroath.packages.$(date +%s)
  }

build_debian11_dependencies() {
  #time docker build --target m2st_dependencies -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee build.sigtools.debian11.arbroath.dependencies.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_dependencies -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee build.sigtools.debian11.arbroath.dependencies.$(date +%s)
}

build_debian11_built() {
  #time docker build --target m2st_built -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee build.sigtools.debian11.arbroath.built.$(date +%s)
  time docker build --build-arg CACHE_DATE="$(date)" --target m2st_built -t avstephen/marte2-sigtools-debian11:arbroath -f Dockerfile.debian11.multistage . 2>&1 | tee build.sigtools.debian11.arbroath.built.$(date +%s)
}


build_debian11_base y
#build_debian11_packages
#build_debian11_dependencies
#build_debian11_built



build_tests() {
  #time docker build -t avstephen/ephemeral-test -f Dockerfile.dateutils.test . 2>&1 | tee build.ephemeral.test.2
  #time docker build -t avstephen/ephemeral-test -f Dockerfile.dateutils.integrated.test . 2>&1 | tee build.dateutils.integrated.test.1
  echo "syntax !"
}

