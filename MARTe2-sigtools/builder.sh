#!/usr/bin/env bash
#
#
# Latch the build commands to ensure reproducibility.

# TODO: test all combinations (cache/no-cache)
# TODO: refactor to eliminate the duplication

usage() {
	echo "usage"
}

###
### GENERIC
###

export CODENAME_CENTOS7=ayr
export DOCKERFILE_CENTOS7=Dockerfile.centos7.multistage
export DOCKER_TAG_PREFIX=avstephen/marte2-sigtools-

build_stage() {

	TARGET_STAGE=$1
	TARGET_OS=$2
	CODENAME=$3
	invalidate_cache=$4

	if [ x"$invalidate_cache" == "xy" ]
	then
		CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
	else
		unset CACHE_OPT
	fi

	this_log="build.${TARGET_OS}.${TARGET_STAGE}.${CODENAME}.$(date +%s)"

	# shellcheck disable=SC2086 # code is rrelevant because quotes areound CACHE_OPT would break
	time docker build ${CACHE_OPT} \
		--target "${TARGET_STAGE}" \
		-t "${DOCKER_TAG_PREFIX}${TARGET_OS}:${CODENAME}" \
		-f "Dockerfile.${TARGET_OS}.multistage" . 2>&1 | tee "$this_log"

	ln -fs "$this_log" "${TARGET_OS}.last.log"

}

build_all(){
	TARGET_OS=$1
	CODENAME=$2
	invalidate_cache=$3
	build_stage m2st_base "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
	build_stage m2st_packages "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
	build_stage m2st_dependencies "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
	build_stage m2st_built "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
}


build_all centos7 ayr n
#build_all ubuntu1804 ayr n
#build_all ubuntu2004 ayr n
#build_all debian11 ayr n



###
### CENTOS7
###

export CODENAME_CENTOS7=ayr
export DOCKERFILE_CENTOS7=Dockerfile.centos7.multistage
export DOCKER_TAG_CENTOS7=avstephen/marte2-sigtools-centos7:${CODENAME_CENTOS7}

build_centos7 () {

	TARGET=$1
	invalidate_cache=$2

	if [ x"$invalidate_cache" == "xy" ]
	then
		CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
	else
		unset CACHE_OPT
	fi

	this_log="build.centos7.${TARGET}.${CODENAME_CENTOS7}.$(date +%s)"

	# shellcheck disable=SC2086 # code is rrelevant because quotes areound CACHE_OPT would break
	time docker build ${CACHE_OPT} \
		--target "${TARGET}" \
		-t "${DOCKER_TAG_CENTOS7}" \
		-f "${DOCKERFILE_CENTOS7}" . 2>&1 | tee "$this_log"

	ln -fs "$this_log" centos7.last.log

}

centos7() {
	build_centos7 m2st_base n
	build_centos7 m2st_packages n
	build_centos7 m2st_dependencies n
	build_centos7 m2st_built y
}


###
### UBUNTU-1804
###

export CODENAME_UBUNTU1804=ayr
export DOCKERFILE_UBUNTU1804=Dockerfile.ubuntu1804.multistage
export DOCKER_TAG_UBUNTU1804=avstephen/marte2-sigtools-ubuntu1804:${CODENAME_UBUNTU1804}

build_ubuntu1804() {

	TARGET="$1"
	invalidate_cache="$2"

	if [ x"$invalidate_cache" == "xy" ]
	then
		CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
	else
		unset CACHE_OPT
	fi

	this_log="build.ubuntu1804.${TARGET}.${CODENAME_UBUNTU1804}.$(date +%s)"

	# shellcheck disable=SC2086 # code is rrelevant because quotes areound CACHE_OPT would break
	time docker build ${CACHE_OPT} \
		--target "${TARGET}" \
		-t "${DOCKER_TAG_UBUNTU1804}" \
		-f "${DOCKERFILE_UBUNTU1804}" . 2>&1 | tee "$this_log"

	ln -fs "$this_log" ubuntu1804.last.log

}

ubuntu1804() {
build_ubuntu1804 m2st_base n
build_ubuntu1804 m2st_packages n
build_ubuntu1804 m2st_dependencies n
	build_ubuntu1804 m2st_built n
}

###
### DEBIAN-11
###

export CODENAME_DEBIAN11=ayr
export DOCKERFILE_DEBIAN11=Dockerfile.debian-11.multistage
export DOCKER_TAG_DEBIAN11=avstephen/marte2-sigtools-debian11:${CODENAME_DEBIAN11}

build_debian11() {

	TARGET=$1
	invalidate_cache=$2

	if [ x"$invalidate_cache" == "xy" ]
	then
		CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
	else
		unset CACHE_OPT
	fi

	this_log="build.debian11.${TARGET}.${CODENAME_DEBIAN11}.$(date +%s)"

	# shellcheck disable=SC2086 # code is rrelevant because quotes areound CACHE_OPT would break
	time docker build ${CACHE_OPT} \
		--target "${TARGET}" \
		-t "${DOCKER_TAG_DEBIAN11}" \
		-f "${DOCKERFILE_DEBIAN11}" . 2>&1 | tee "$this_log"

	ln -fs "$this_log" debian11.last.log

}

debian11() {
	build_debian11 m2st_base n
build_debian11 m2st_packages n
	build_debian11 m2st_dependencies n
	build_debian11 m2st_built n
}


###
### Main
###

#ubuntu1804
#centos7
#debian11
