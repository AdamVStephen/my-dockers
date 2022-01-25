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
export EPICS_BASE=${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.6
export EPICSPVA=${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.6
export EPICS_HOST_ARCH=linux-x86_64
export SDN_CORE_INCLUDE_DIR=${MARTe2_Sigtools_PROJECTS_ROOT}/SDN_1.0.12_nonCCS/src/main/c++/include/
export SDN_CORE_LIBRARY_DIR=${MARTe2_Sigtools_PROJECTS_ROOT}/SDN_1.0.12_nonCCS/target/lib/
export PATH=$PATH:${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.6/bin/linux-x86_64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MARTe2_DIR/Build/x86-linux/Core/:$EPICS_BASE/lib/$EPICS_HOST_ARCH:$SDN_CORE_LIBRARY_DIR
#export MDSPLUS_DIR=/usr/local/mdsplus

install_prereq() {
    yum -y install epel-release && yum -y update
    # Development package as a group
    yum -y groups install "Development Tools"
    # Extras that are generally useful
    yum -y install wget cmake3 octave libxml libxml2-devel bc vim w3m lsof

    # Configure cmake3 as cmake
    alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 --family cmake

    # Dependencies to build MARTe2 and EPICS
    yum -y install ncurses-devel readline-devel
    # Python and Perl Parse utilities for open62541 (open source impleemntation of OPC UA based on IEC 62541)
    yum -y install python-dateutil python-six perl-ExtUtils-ParseXS
    # MDSplus
    yum -y install http://www.mdsplus.org/dist/el7/stable/RPMS/noarch/mdsplus-repo-7.50-0.el7.noarch.rpm
    yum -y install mdsplus-kernel* mdsplus-java* mdsplus-python* mdsplus-devel*
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

    cd ${MARTe2_Sigtools_PROJECTS_ROOT} || { echo "${MARTe2_Sigtools_PROJECTS_ROOT} does not exist"; exit 42;}

    # MARTe2-sigtools which pulls in MARTe and MARTe2-components
    git clone --recursive -b develop https://github.com/AdamVStephen/MARTe2-sigtools
    ln -sf ${MARTe2_PROJECTS_ROOT}/MARTe2 ${MARTe2_PROJECTS_ROOT}/MARTe2-dev

    # MARTe2-demos-padova
    git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova.git 

    # EPICS R7.0.2
    # Padua 2019 compatibility
    #git clone -b R7.0.2 --recursive https://github.com/epics-base/epics-base.git epics-base-7.0.2

    # Open Source OPCUA 
    # Padua 2019 compatibility
    # git clone -b 0.3 https://github.com/open62541/open62541.git

    # EPICS R7.0.6
    git clone -b R7.0.6 --recursive https://github.com/epics-base/epics-base.git epics-base-7.0.6

    # Open Source OPCUA 
    git clone -b develop https://github.com/open62541/open62541.git

    # Download SDN:
    wget https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova/raw/develop/Other/SDN_1.0.12_nonCCS.tar.gz

    tar zxvf SDN_1.0.12_nonCCS.tar.gz

    # Build the open62541 library:

    mkdir ${MARTe2_Sigtools_PROJECTS_ROOT}/open62541/build && cd $_ && cmake3 .. && make

    # Compile SDN:

    cd ${MARTe2_Sigtools_PROJECTS_ROOT}/SDN_1.0.12_nonCCS && make

    #Compiling EPICS 7.0.2
    cd ${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.2 && echo "OP_SYS_CXXFLAGS += -std=c++11" >> configure/os/CONFIG_SITE.linux-x86_64.Common
    cd ${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.2 && make

    #Compiling EPICS 7.0.6
    cd ${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.6 && echo "OP_SYS_CXXFLAGS += -std=c++11" >> configure/os/CONFIG_SITE.linux-x86_64.Common
    cd ${MARTe2_Sigtools_PROJECTS_ROOT}/epics-base-7.0.6 && make
    touch ${MARTe2_Sigtools_Installed_File}
}

build_marte() {
    # Build MARTe
    MDSPLUS_DIR=/usr/local/mdsplus

    cd ${MARTe2_PROJECT_ROOT}/MARTe2-dev && git checkout 99c7d76af4 && make -f Makefile.linux
    cd ${MARTe2_PROJECT_ROOT}/MARTe2-components && git checkout 00a08ac && make -f Makefile.linux
    cd /root/Projects/MARTe2-demos-padova && make -f Makefile.x86-linux

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





