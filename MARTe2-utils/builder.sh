#!/usr/bin/env bash
#

export DOCKER_TAG_PREFIX=avstephen/marte2-utils-

export SUPPORTED_DISTROS="centos7 ubuntu1804 ubuntu2004 debian11"

export SUPPORTED_TAGS="barrhead v1.0.0"

usage() {
	echo "builder.sh distro [codename] : runs a Docker build for marte2"
	echo
	echo "Supported distros"
	for d in ${SUPPORTED_DISTROS}
	do
		echo -e "\t$d"
	done
	exit 42
}


build_stage() {

	TARGET_STAGE=$1
	TARGET_OS=$2
	TAG=$3
	invalidate_cache=$4

	if [ x"$invalidate_cache" == "xy" ]
	then
		CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
	else
		unset CACHE_OPT
	fi

	this_log="build.${TARGET_OS}.${TARGET_STAGE}.${TAG}.$(date +%s)"

	# shellcheck disable=SC2086 # code is rrelevant because quotes areound CACHE_OPT would break
	time docker build ${CACHE_OPT} \
		--target "${TARGET_STAGE}" \
		-t "${DOCKER_TAG_PREFIX}${TARGET_OS}:${TAG}" \
		-f "Dockerfile.${TARGET_OS}.multistage.${TAG}" . 2>&1 | tee "$this_log"

	ln -fs "$this_log" "${TARGET_OS}.last.log"

}

build_all(){
	TARGET_OS=$1
	TAG=$2
	invalidate_cache=$3
	build_stage m2st_base "${TARGET_OS}" "${TAG}" "${invalidate_cache}"
	build_stage m2st_packages "${TARGET_OS}" "${TAG}" "${invalidate_cache}"
	build_stage m2st_dependencies "${TARGET_OS}" "${TAG}" "${invalidate_cache}"
	build_stage m2st_built "${TARGET_OS}" "${TAG}" "${invalidate_cache}"
}

#build_all centos7 ayr y
#build_all ubuntu1804 barrhead y
#build_all ubuntu2004 barrhead y
#build_all debian11 barrhead y

### TODO: get a grip on parsing args and options in bash !

if [ $# -eq 0 ]
then
	usage
	exit 0
else
distro=$1
shift
if [[ "$SUPPORTED_DISTROS" =~ (^|[[:space:]])"$distro"($|[[:space:]]) ]]
then
	#echo "$distro IS supported : congratulations"
	#build_all "$distro" ayr y
	build_all "$distro" v1.0.0 y
else
	usage
	exit 54
fi
fi