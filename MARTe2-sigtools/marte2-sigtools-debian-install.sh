#!/usr/bin/env bash
#
# 2022-01-22 passes shellcheck linting OK.
# 2022-01-22 : bashtip : surround shell expansion strings in double quotes : shellcheck
# 2022-01-22 : bashtip : use || exit after a cd attempt in case the directory is not found : shellcheck

# Commands taken from the equivalent Dockerfile.debian and revised for a real machine
#Environment variables

export MARTe2_Sigtools_PROJECTS_ROOT=${HOME}/Projects
export MARTe2_PROJECT_ROOT=${MARTe2_Sigtools_PROJECTS_ROOT}/MARTe2-sigtools
export MARTe2_Sigtools_Installed_File=${MARTe2_PROJECT_ROOT}/marte2-sigtools.installed
export MARTe2_Sigtools_Installed_File=${MARTe2_PROJECT_ROOT}/marte2-sigtools.installed
export MARTe2_DIR=${MARTe2_PROJECT_ROOT}/MARTe2-dev
export MARTe2_Components_DIR=${MARTe2_PROJECT_ROOT}/MARTe2-components
export MARTe2_Demos_Sigtools_DIR=${MARTe2_PROJECT_ROOT}/MARTe2-demos-sigtools/
# Avoid building the OPCUADataSource by suppressing the next two lines
# https://github.com/AdamVStephen/MARTe2-sigtools/blob/issues/issues/%230001_MARTe2-components_build/OPCUAClient.md
#export OPEN62541_LIB=${MARTe2_PROJECT_ROOT}/Projects/open62541/build/bin
#export OPEN62541_INCLUDE=${MARTe2_PROJECT_ROOT}/Projects/open62541/build
export EPICS_BASE=${MARTe2_PROJECT_ROOT}/Projects/epics-base-7.0.6
export EPICSPVA=${MARTe2_PROJECT_ROOT}/Projects/epics-base-7.0.6
export EPICS_HOST_ARCH=linux-x86_64
export SDN_CORE_INCLUDE_DIR=${MARTe2_PROJECT_ROOT}/Projects/SDN_1.0.12_nonCCS/src/main/c++/include/
export SDN_CORE_LIBRARY_DIR=${MARTe2_PROJECT_ROOT}/Projects/SDN_1.0.12_nonCCS/target/lib/
export PATH=$PATH:${MARTe2_PROJECT_ROOT}/Projects/epics-base-7.0.6/bin/linux-x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MARTe2_DIR/Build/x86-linux/Core/:$EPICS_BASE/lib/$EPICS_HOST_ARCH:$SDN_CORE_LIBRARY_DIR
#export MDSPLUS_DIR=/usr/local/mdsplus


install_prereq() {
	apt-get update && apt-get install -y build-essential
	apt-get -y install wget octave libxml2 libxml2-dev bc vim git
	wget -qO- "https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4-linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local
	update-alternatives --install /usr/bin/cmake3 cmake /usr/local/bin/cmake 20 --slave /usr/bin/ctest3 ctest /usr/local/bin/ctest --slave /usr/bin/cpack3 cpack /usr/local/bin/cpack --slave /usr/local/bin/ccmake3 ccmake /usr/local/bin/ccmake 
	apt-get -y install ncurses-dev libreadline-dev
	apt-get -y install python3-dateutil python3-six 
	# Install Development dependencies for SDN (libz !)
	apt-get install -y zlib1g-dev
	echo "Prerequisites installed"
	touch ${MARTe2_Sigtools_Installed_File}
}


clone_sigtools() {
	if [ ! -d ${MARTe2_PROJECT_ROOT} ]
	then
		mkdir -p ${MARTe2_PROJECT_ROOT}
	fi
	cd ${{MARTe2_Sigtools_PROJECTS_ROOT} || { echo "${MARTe2_Sigtools_PROJECTS_ROOT} does not exist"; exit 42;}
	git clone --recursive -b develop https://github.com/AdamVStephen/MARTe2-sigtools
	ln -sf ${MARTe2_PROJECT_ROOT}/MARTe2 ${MARTe2_PROJECT_ROOT}/MARTe2-dev
	git clone -b R7.0.6 --recursive https://github.com/epics-base/epics-base.git epics-base-7.0.6
	#git clone -b 0.3 https://github.com/open62541/open62541.git
	wget https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova/raw/develop/Other/SDN_1.0.12_nonCCS.tar.gz
	tar zxvf SDN_1.0.12_nonCCS.tar.gz
	# Build the open62541 library:
	#mkdir ~/Projects/open62541/build && cd ~/Projects/open62541/build && cmake3 .. && make
	cd ${MARTe2_PROJECT_ROOT}/Projects/SDN_1.0.12_nonCCS && make
	#Compiling EPICS
	cd ${MARTe2_PROJECT_ROOT}/Projects/epics-base-7.0.6 && echo "OP_SYS_CXXFLAGS += -std=c++11" >> configure/os/CONFIG_SITE.linux-x86_64.Common
	cd ${MARTe2_PROJECT_ROOT}/Projects/epics-base-7.0.6 && make
	touch ${MARTe2_Sigtools_Installed_File}
}

build_marte() {
	#cd ${MARTe2_PROJECT_ROOT}/MARTe2-dev && git checkout 99c7d76af4 && make -f Makefile.linux
	#cd ${MARTe2_PROJECT_ROOT}/MARTe2-components && git checkout 00a08ac && make -f Makefile.linux
	#cd //home/adam/Projects/MARTe2-demos-padova && make -f Makefile.x86-linux

# If working : todo is to latch the commit which built correctly 
#RUN cd ${MARTe2_PROJECT_ROOT}/MARTe2-dev && git checkout develop && make -f Makefile.linux
#RUN cd ${MARTe2_PROJECT_ROOT}/MARTe2-components && git checkout 00a08ac && make -f Makefile.linux
#RUN cd //home/adam/Projects/MARTe2-demos-padova && make -f Makefile.x86-linux
exit 0
}


if [ "$(whoami)" == "root" ]
then
	echo "Run as root user : install prerequisites if necessary"
	if [ -f /root/marte2-sigtools.installed ]
	then
		echo "Installed already (allegedly)"
	else
		install_prereq
	fi
else
	if [ -f ${MARTe2_Sigtools_Installed_File} ]
	then
		echo "marte2-sigtools already installed"
	else
		clone_sigtools
	fi
fi
