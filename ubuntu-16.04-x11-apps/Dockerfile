FROM ubuntu:16.04

# Base image 16.04 chosen as it is currently highest supported version for Wind River VxWorks tools

MAINTAINER Adam Vercingetorix Stephen

LABEL version="1.0"
LABEL description="Base Ubuntu 16.04 with X support suitable for installation of Wind River VxWorks and development"

# Update and install x11-apps plus a browser
#
# Additional useful packages for development 

RUN apt-get update && apt-get install -y x11-apps firefox tmux git wget 

# The Canonical 16.04 container image removed a lot of stuff to slim down.
# And broke many docker containers inheriting from generic ubuntu in the process
# See gihub.com/tianon/docker-brew-ubuntu-core/issues/48

RUN apt-get -y install sudo

# Tip to keep docker images efficient
# Possibly a bad idea
#RUN apt-get -qy autoremove

# Add account fusion as a non-privileged user

RUN export uid=1006 gid=1007 && \
	echo "fusion:x:${uid}:${gid}:fusion,,,:/home/fusion:/bin/bash" >> /npuser.txt && \
	echo "fusion:x:${uid}:${gid}:fusion,,,:/home/fusion:/bin/bash" >> /etc/passwd && \
	echo "fusion:x:${gid}:fusion" >> /etc/group && \
	mkdir -p /home/fusion && \
	chown ${uid}:${gid} -R /home/fusion


# Permit fusion account to sudo without passsword

RUN echo "fusion ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/fusion
 
USER fusion
ENV HOME /home/fusion
CMD /usr/bin/firefox
