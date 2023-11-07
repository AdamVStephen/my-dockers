FROM debian:buster-20231030-slim

# Buster aka Debian 10 EOL 10/09/2022  Official docker image for buster slim dated Oct 2023 still available.
# Create a non-privileged user for MARTe development

##RUN export uid=1006 gid=1007 && \
#	echo "marte-dev:x:${uid}:${gid}:marte-dev,,,:/home/marte-dev:/bin/bash" >> /npuser.txt && \
#	echo "marte-dev:x:${uid}:${gid}:marte-dev,,,:/home/marte-dev:/bin/bash" >> /etc/passwd && \
#	echo "marte-dev:x:${gid}:marte-dev" >> /etc/group && \
#	mkdir -p /home/marte-dev && \
#	chown ${uid}:${gid} -R /home/marte-dev
#
#USER marte-dev
#ENV HOME /home/marte-dev

RUN apt-get update
RUN apt-get install -y wget build-essential

# Grab a copy of the cint sources.
RUN wget https://github.com/AdamVStephen/cint/archive/master.zip

RUN apt-get install -y unzip

RUN cd /opt && unzip /master.zip

RUN cd /opt/cint-master && tar -zxvf cint-5.18.00.tgz

RUN apt-get install -y unzip

RUN apt-get install -y libreadline-dev

RUN apt-get install -y vim less

# For the jessie (Debian 8) based image, there was a version plus jre-1.7.0
# So provide java with the buster update
RUN apt-get install -y default-jre

# Invoke with --build-arg CACHEBUST=$(date +%s) to force no-cache beyond here
# Necessary to ensure the configure is rerun to populate the source directory

ARG CACHEBUST=1

RUN cd /opt/cint-master/cint-5.18.00 && ./configure --prefix=/opt --readlinelib=/usr/lib/x86_64-linux-gnu/libreadline.so

RUN cd /opt/cint-master/cint-5.18.00 && sed -i -e 's/CXXFLAGS      =/CXXFLAGS      = -std=gnu++03/g' Makefile 

# Apply CXXFLAGS patch also at the build/ level which is copied into the source level later
RUN cd /opt/cint-master/cint-5.18.00/build && sed -i -e 's/CXXFLAGS      =/CXXFLAGS      = -std=gnu++03/g' Makefile 

RUN cd /opt/cint-master/cint-5.18.00 && make 

RUN cd /opt/cint-master/cint-5.18.00 && make install

 


# Extract the MARTe source code
#RUN mkdir -p /home/marte-dev/MARTe/MARTe-1.0/toomanych
#RUN echo "Damien Karkinsky integrated MARTe 1.0 sources from 2019" >> /home/marte-dev/MARTe/MARTe-1.0/README.md
#RUN echo "cloned from github via git clone http://github.com/toomanych/MARTe1" >> /home/marte-dev/MARTe/MARTe-1.0/README.md
#RUN cd /home/marte-dev/MARTe/MARTe-1.0/toomanych && git clone http://github.com/toomanych/MARTe1

CMD /bin/bash





