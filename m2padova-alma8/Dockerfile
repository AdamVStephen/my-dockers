FROM almalinux/8-base

## Refresh wrt versions as of 2026-08-22
# First attempt - stick with old version of epics7.0.8

## Add EPEL repository and update
RUN yum -y install epel-release && yum -y update
#
RUN yum -y install less
## Git is essential
RUN yum -y install git
## Development package as a group
RUN yum -y groups install "Development Tools"
## Extras that are generally useful
RUN yum -y install wget cmake3 
#RUN yum -y install octave 
#
RUN yum -y install libxml2 libxml2-devel bc
## Dependencies to build MARTe2 and EPICS
RUN yum -y install ncurses-devel readline-devel
## Python and Perl Parse utilities for open62541 (open source impleemntation of OPC UA based on IEC 62541)
RUN yum -y install python3 python3-pip
RUN pip3 install python-dateutil six
RUN yum -y install perl-ExtUtils-ParseXS
## MDSplus
#RUN yum -y install http://www.mdsplus.org/dist/el7/stable/RPMS/noarch/mdsplus-repo-7.50-0.el7.noarch.rpm
RUN yum -y install http://www.mdsplus.org/dist/rhel8/stable/RPMS/noarch/mdsplus-repo-7.142-81.el8.noarch.rpm
RUN yum -y install mdsplus-kernel* mdsplus-java* mdsplus-python* mdsplus-devel*
#
## Workspace to download and compile code from source
ENV MARTe2_ROOT=/root/Projects
WORKDIR $MARTe2_ROOT
#
## MARTe core, components and Padova training demos
##
## Caveat : requires git with openssl TLS support; on other distros YMMV.   
## See dockerhub avstephen/u18-git-openssl for a fix.
RUN git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2.git MARTe2
#RUN git clone -b \#351_OPCUA https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-components.git
# TODO : work on the OPCUA layer update
RUN git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-components.git
RUN git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova.git 
#
## EPICS R7.0.8
RUN git clone -b R7.0.8 --recursive https://github.com/epics-base/epics-base.git epics-base-7.0.8
## Open Source OPCUA 
RUN git clone -b 0.3 https://github.com/open62541/open62541.git
## Download SDN:
RUN wget https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova/raw/develop/Other/SDN_1.0.12_nonCCS.tar.gz
#
RUN tar zxvf SDN_1.0.12_nonCCS.tar.gz
#
## Compile SDN:
#
RUN cd ~/Projects/SDN_1.0.12_nonCCS && make
#
##Compiling EPICS
#
RUN cd epics-base-7.0.8 && echo "OP_SYS_CXXFLAGS += -std=c++11" >> configure/os/CONFIG_SITE.linux-x86_64.Common
RUN cd epics-base-7.0.8 && make
#
## Environment variables
#
ENV MARTe2_DIR=$MARTe2_ROOT/MARTe2
ENV MARTe2_Components_DIR=$MARTe2_ROOT/MARTe2-components
ENV OPEN62541_LIB=$MARTe2_ROOT/open62541/build/bin
ENV OPEN62541_INCLUDE=$MARTe2_ROOT/open62541/build
ENV EPICS_BASE=$MARTe2_ROOT/epics-base-7.0.8
ENV EPICSPVA=$MARTe2_ROOT/epics-base-7.0.8
ENV EPICS_HOST_ARCH=linux-x86_64
ENV SDN_CORE_INCLUDE_DIR=$MARTe2_ROOT/SDN_1.0.12_nonCCS/src/main/c++/include/
ENV SDN_CORE_LIBRARY_DIR=$MARTe2_ROOT/SDN_1.0.12_nonCCS/target/lib/
ENV PATH=$PATH:$MARTe2_ROOT/epics-base-7.0.8/bin/linux-x86_64
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MARTe2_DIR/Build/x86-linux/Core/:$EPICS_BASE/lib/$EPICS_HOST_ARCH:$SDN_CORE_LIBRARY_DIR
#
## Configure cmake3 as cmake
RUN alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake3 20 --slave /usr/local/bin/ctest ctest /usr/bin/ctest3 --slave /usr/local/bin/cpack cpack /usr/bin/cpack3 --slave /usr/local/bin/ccmake ccmake /usr/bin/ccmake3 --family cmake
# open62541 requires python3 to be set as system python
RUN alternatives --set python /usr/bin/python3
## Build the open62541 library:
ENV OPEN62541_DIR=/opt/open62541-1.0
ENV OPEN62541_TGZ=open62541-v1.0.tar.gz
ENV OPEN62541_SRC_DIR=$OPEN62541_DIR/open62541-open62541-ce5209d
ENV OPEN62541_BUILD_DIR=$OPEN62541_SRC_DIR/build
ENV OPEN62541_INCLUDE=$OPEN62541_BUILD_DIR
ENV OPEN62541_LIB=$OPEN62541_BUILD_DIR/bin

# Instructions from the README in the MARTe2-components sources
# https://github.com/aneto0/MARTe2-components/blob/master/Source/Components/DataSources/OPCUADataSource/README.md
RUN mkdir -p $OPEN62541_DIR
RUN wget -O $OPEN62541_DIR/$OPEN62541_TGZ https://api.github.com/repos/open62541/open62541/tarball/v1.0
RUN cd $OPEN62541_DIR && tar zxf $OPEN62541_TGZ 
# Unique Patterns can be commented using standard sed notation
RUN cd $OPEN62541_SRC_DIR && sed -i -e 's/\(include(CheckIPO\)/#\1/' CMakeLists.txt
RUN cd $OPEN62541_SRC_DIR && sed -i -e 's/\(check_ipo_supported\)/#\1/' CMakeLists.txt
RUN cd $OPEN62541_SRC_DIR && sed -i -e 's/\(if(CC_HAS_IPO)\)/#\1/' CMakeLists.txt
RUN cd $OPEN62541_SRC_DIR && sed -i -e 's/\(set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_ON)\)/#\1/' CMakeLists.txt
# Commenting the closing endif() line needs a little finesse to express "line following pattern"
# and also to deal with the whitespace
RUN cd $OPEN62541_SRC_DIR && sed -i -e '/.*OPTIMIZATION.*/!b;$!N;/\n\(\s*endif()\)/s//\n\#\1/;P;D' CMakeLists.txt

RUN mkdir -p $OPEN62541_BUILD_DIR && cd $OPEN62541_BUILD_DIR && cmake3 -DUA_ENABLE_AMALGAMATION=ON .. && make

## Build MARTe

ENV MDSPLUS_DIR=/usr/local/mdsplus

ENV MARTe2_BUILD_DATE=2024-10-26

ENV MARTe2_CORE_MASTER_TAG=v1.10.4
RUN cd $MARTe2_ROOT/MARTe2 && git checkout $MARTe2_CORE_MASTER_TAG && make -f Makefile.linux
#
ENV MARTe2_COMPONENTS_MASTER_TAG=v1.10.4
RUN cd $MARTe2_ROOT/MARTe2-components && git checkout $MARTe2_COMPONENTS_MASTER_TAG && make -f Makefile.linux

## Small patch required for a strengthened warning
ENV MARTe2_DEMOS_PADOVA_COMMIT=1cc1a54dc
RUN cd $MARTe2_ROOT/MARTe2-demos-padova && git checkout $MARTe2_DEMOS_PADOVA_COMMIT && sed -i -e '496s/\(std::cout.*\)\(std::cout.*\)/{\n\t\t\1\n\t\t}\n\t\2/p' DataSources/MDSReaderNS/MDSReaderNS.cpp && make -f Makefile.x86-linux

## Perform the Tutorial Installation 
ENV MARTe2_TUTORIAL_DIR=$MARTe2_DIR/Docs/User/source/_static/tutorial
# Note convention expected by Tutorial
ENV MARTE_TRAINING_PARENT_DIR=$MARTe2_ROOT
#RUN mkdir -p $MARTE_TRAINING_PARENT_DIR/MARTe2-training-proj
# InstallTraining.sh requires rsync
RUN yum -y install rsync
RUN cd $MARTe2_TUTORIAL_DIR && ./InstallTraining.sh

# Add Vim
RUN yum -y install vim

## Add MARTe2-utils for m2 script
RUN cd $MARTe2_ROOT && git clone https://github.com/AdamVStephen/MARTe2-utils
#RUN cd $MARTe2_ROOT && git pull
ENV MARTe2_UTILS=$MARTe2_ROOT/MARTe2-utils
ENV PATH=$PATH:$MARTe2_UTILS/bin
ENV MARTe2_ACTIVE_PROJECT_PADOVA=$MARTe2_ROOT/MARTe2-demos-padova
ENV MARTe2_ACTIVE_PROJECT_TRAINING=$MARTe2_ROOT/MARTe2-training-proj
ENV MARTe2_ACTIVE_PROJECT=$MARTe2_ACTIVE_PROJECT_TRAINING

RUN echo "cd $MARTe2_UTILS && . ./bin/m2-completion.bash" >> /root/.bashrc

CMD /bin/bash

