#!/usr/bin/env bash
#
#
# Latch the build commands to ensure reproducibility.



build_it() {

	invalidate_cache=$1

	if [ x"$invalidate_cache" == "xy" ]
	then
		CACHE_OPT="--build-arg CACHE_DATE=$(date +%s) "
	else
		unset CACHE_OPT
	fi

	this_log="build.cxx.nash.$(date +%s)"

	# shellcheck disable=SC2086 # code is rrelevant because quotes areound CACHE_OPT would break
	time docker build ${CACHE_OPT} \
		-t "avstephen/cxx-nash:latest" \
		-f "Dockerfile.cxx.nash" . 2>&1 | tee "$this_log"

	ln -fs "$this_log" "last.log"

}
build_it
