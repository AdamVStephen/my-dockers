#!/usr/bin/env bash
#
# Install package dependencies.  Only necessary on a machine not previously configured for MARTe2
#
# Original repository : https://github.com/AdamVStephen/MARTe2-sigtools

#set -x
# Guard against unset variable expansion
set -u
SCRIPT="$0"
SCRIPT_DIR=$(dirname $(realpath "$SCRIPT"))
SETENV_SCRIPT_PATH="$SCRIPT_DIR/marte2-sigtools-setenv.sh"

if [ -f "$SETENV_SCRIPT_PATH" ]
then
  source "$SETENV_SCRIPT_PATH"
else
  echo "$SETENV_SCRIPT_PATH not found.  Bailing out"
  exit 54
fi

# Import common shell functions
source "${SCRIPT_DIR}/marte2-sigtools-utils.sh"

#cd ${MARTe2_PROJECT_ROOT}/MARTe2-dev && git checkout 99c7d76af4 && make -f Makefile.linux
#cd ${MARTe2_PROJECT_ROOT}/MARTe2-components && git checkout 00a08ac && make -f Makefile.linux
#cd /root/Projects/MARTe2-demos-padova && make -f Makefile.x86-linux
#
# Look up table of known good combinations of branches and OS versions
#
declare -A core_branch=( ["centos7"]="99c7d76af4" ["debian11"]="" )
declare -A components_branch=( ["centos7"]="00a08ac"  ["debian11"]="" )

build_marte() {
  core_sha=$1
  components_sha=$2
  #echo "build marte for $core_sha and $components_sha"
  cd ${MARTe2_PROJECT_ROOT}/MARTe2-dev && git checkout "$core_sha" && make -f Makefile.linux 2>&1 | tee "build.$core_sha.$(date +%s).log"
  cd ${MARTe2_PROJECT_ROOT}/MARTe2-components && git checkout "$components_sha" && make -f Makefile.linux 2>&1 | tee "build.$components_sha.$(date +%s).log"
  # Build demos-padova manually pending resolving optional MDSPLUS support
  #cd ${MARTe2_PROJECT_ROOT}/MARTe2-demos-padova && make -f Makefile.x86-linux 2>&1 | tee "build.$(date +%s)log"
  #cd ${MARTe2_PROJECT_ROOT}/MARTe2-demos-padova && make -f Makefile.x86-linux 2>&1 | tee "build.$(date +%s)log"
}

usage() {
  echo "$SCRIPT [core sha] [components sha]"
  exit 54 
}

#echo "Called with $# arguments"
this_distro=$(get_distro)
#echo "This distro is $this_distro"

export DEFAULT_CORE_SHA="develop"
export DEFAULT_COMPONENTS_SHA="develop"

case $# in
  0) echo "Defaults null"
	export CORE_SHA=${core_branch[$this_distro]:=$DEFAULT_CORE_SHA}
	export COMPONENTS_SHA=${components_branch[$this_distro]:=$DEFAULT_COMPONENTS_SHA}
  ;;
  1) echo "Defaults core sha"
	export CORE_SHA=$1
	export COMPONENTS_SHA=${components_branch[$this_distro]:=$DEFAULT_COMPONENTS_SHA}
  ;;
  2) echo "both sha"
	export CORE_SHA=$1
	export COMPONENTS_SHA=$2
  ;;
  *) echo "Defaults non-null"
	usage
  ;;
esac

build_marte "$CORE_SHA" "$COMPONENTS_SHA"

exit 0
