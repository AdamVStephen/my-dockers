FROM almalinux/8-base

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
WORKDIR /root/Projects
#
## MARTe core, components and Padova training demos
##
## Caveat : requires git with openssl TLS support; on other distros YMMV.   See dockerhub avstephen/u18-git-openssl for a fix.
RUN git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2.git MARTe2-dev
#RUN git clone -b \#351_OPCUA https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-components.git
# TODO : work on the OPCUA layer update
RUN git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-components.git
RUN git clone https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova.git 
#
## EPICS R7.0.2
#RUN git clone -b R7.0.2 --recursive https://github.com/epics-base/epics-base.git epics-base-7.0.2
#
## EPICS R7.0.8
RUN git clone -b R7.0.8 --recursive https://github.com/epics-base/epics-base.git epics-base-7.0.8
## Open Source OPCUA 
RUN git clone -b 0.3 https://github.com/open62541/open62541.git
#
## Download SDN:
#
RUN wget https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-demos-padova/raw/develop/Other/SDN_1.0.12_nonCCS.tar.gz
#
RUN tar zxvf SDN_1.0.12_nonCCS.tar.gz
#
#
## Compile SDN:
#
RUN cd ~/Projects/SDN_1.0.12_nonCCS && make
#
##Compiling EPICS
#RUN cd epics-base-7.0.2 && echo "OP_SYS_CXXFLAGS += -std=c++11" >> configure/os/CONFIG_SITE.linux-x86_64.Common
#RUN cd epics-base-7.0.2 && make
#
RUN cd epics-base-7.0.8 && echo "OP_SYS_CXXFLAGS += -std=c++11" >> configure/os/CONFIG_SITE.linux-x86_64.Common
RUN cd epics-base-7.0.8 && make
##Environment variables
ENV MARTe2_DIR=/root/Projects/MARTe2-dev
ENV MARTe2_Components_DIR=/root/Projects/MARTe2-components
ENV OPEN62541_LIB=/root/Projects/open62541/build/bin
ENV OPEN62541_INCLUDE=/root/Projects/open62541/build
ENV EPICS_BASE=/root/Projects/epics-base-7.0.8
ENV EPICSPVA=/root/Projects/epics-base-7.0.8
ENV EPICS_HOST_ARCH=linux-x86_64
ENV SDN_CORE_INCLUDE_DIR=/root/Projects/SDN_1.0.12_nonCCS/src/main/c++/include/
ENV SDN_CORE_LIBRARY_DIR=/root/Projects/SDN_1.0.12_nonCCS/target/lib/
ENV PATH=$PATH:/root/Projects/epics-base-7.0.8/bin/linux-x86_64
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
ENV MARTE2_BUILD_DATE=2024-10-26

ENV MARTE2_CORE_MASTER_TAG=v1.9.2
RUN cd /root/Projects/MARTe2-dev && git checkout $MARTE2_CORE_MASTER_TAG && make -f Makefile.linux

ENV MARTE2_COMPONENTS_MASTER_TAG=v1.8.0
# Temporary bug patch in v1.8.0 for OPCUA DataSource build.
RUN cd /root/Projects/MARTe2-components/Source/Components/Interfaces/OPCUA && sed -i -e 's/\(LIBRARIES_STATIC.*LIBEXT.*\)/#\1/' Makefile.gcc
RUN cd /root/Projects/MARTe2-components && git checkout $MARTE2_COMPONENTS_MASTER_TAG && make -f Makefile.linux

# Small patch required for a strengthened warning
ENV MARTE2_DEMOS_PADOVA_COMMIT=1cc1a54dc
RUN cd /root/Projects/MARTe2-demos-padova && git checkout $MARTE2_DEMOS_PADOVA_COMMIT && sed -i -e '496s/\(std::cout.*\)\(std::cout.*\)/{\n\t\t\1\n\t\t}\n\t\2/p' DataSources/MDSReaderNS/MDSReaderNS.cpp && make -f Makefile.x86-linux

CMD /bin/bash

