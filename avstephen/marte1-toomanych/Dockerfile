FROM avstephen/gcc-cint:buster-20231030-slim

# 2023-11-07 Reviving MARTe/1 for a New Generation
# Adam Vercingetorix Stephen, Fusionics Engineer.

# Any final image software installation prior to root user must run here. 

RUN apt-get install -y git

RUN apt-get install -y gdb

RUN apt-get install -y tmux

RUN apt-get install -y default-jdk

RUN apt-get install -y procps

RUN apt-get install -y strace

RUN apt-get install -y syslog-ng

RUN apt-get install -y netcat

# TODO: is code required for new developers?

#RUN apt-get install -y snapd

#RUN snap install code --classic

# Create a non-privileged user for MARTe development

RUN export uid=1006 gid=1007 && \
	echo "marte-dev:x:${uid}:${gid}:marte-dev,,,:/home/marte-dev:/bin/bash" >> /npuser.txt && \
	echo "marte-dev:x:${uid}:${gid}:marte-dev,,,:/home/marte-dev:/bin/bash" >> /etc/passwd && \
	echo "marte-dev:x:${gid}:marte-dev" >> /etc/group && \
	mkdir -p /home/marte-dev && \
	chown ${uid}:${gid} -R /home/marte-dev && \
        adduser marte-dev sudo

USER marte-dev
ENV HOME /home/marte-dev

# Extract the MARTe source code
RUN mkdir -p /home/marte-dev/MARTe/MARTe-1.0/toomanych

RUN echo "Damien Karkinsky integrated MARTe 1.0 sources from 2019" >> /home/marte-dev/MARTe/MARTe-1.0/README.md

RUN echo "cloned from github via git clone http://github.com/toomanych/MARTe1" >> /home/marte-dev/MARTe/MARTe-1.0/README.md

WORKDIR /home/marte-dev/MARTe/MARTe-1.0/toomanych 

RUN git clone http://github.com/toomanych/MARTe1

WORKDIR /home/marte-dev/MARTe/MARTe-1.0/toomanych/MARTe1

RUN git checkout develop

# Uncomment build of the Relay logger (could put into MARTe repo)

RUN sed -i -e 's/#Relay/Relay/g' config.MARTe

# Add shebang line to make the compile script compatible with Docker
RUN sed -i -e '1s;^;#!/usr/bin/env bash\n;' compile.MARTe
 
# Compile everything
RUN ./compile.MARTe linux config.MARTe clean

RUN ./compile.MARTe linux config.MARTe all


# Entry point
CMD /bin/bash
