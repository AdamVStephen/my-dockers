#!/usr/bin/env bash
#

export DOCKER_TAG_PREFIX=avstephen/marte2_codegen-

export SUPPORTED_DISTROS="ubuntu2004"

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
	#build_stage marte2_codegen_base "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
	build_stage marte2_codegen_preinstall "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
	build_stage marte2_codegen "${TARGET_OS}" "${CODENAME}" "${invalidate_cache}"
}

#build_all centos7 ayr y
#build_all ubuntu1804 ayr n
#build_all ubuntu2004 ayr n
#build_all debian11 ayr n

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
build_all "$distro" ayr y
#build_all "$distro" ayr n
#	build_all "$distro" ayr y
else
	usage
	exit 54
fi
fi