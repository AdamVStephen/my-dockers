FROM ubuntu:16.04

# Base image 16.04 chosen as it is currently highest supported version for Wind River VxWorks tools

MAINTAINER Adam Vercingetorix Stephen

LABEL version="1.0"
LABEL description="Base Ubuntu 16.04 with X support suitable for installation of Wind River VxWorks and development"

# Update and install x11-apps plus a browser
#
# Additional useful packages for development 

RUN apt-get update && apt-get install -y x11-apps firefox tmux git wget 


# Tip to keep docker images efficient
RUN apt-get -qy autoremove

# Add account astephen as a non-privileged user

RUN export uid=1006 gid=1007 && \
	echo "astephen:x:${uid}:${gid}:astephen,,,:/home/astephen:/bin/bash" >> /npuser.txt && \
	echo "astephen:x:${uid}:${gid}:astephen,,,:/home/astephen:/bin/bash" >> /etc/passwd && \
	echo "astephen:x:${gid}:astephen" >> /etc/group && \
	mkdir -p /home/astephen && \
	chown ${uid}:${gid} -R /home/astephen

USER astephen
ENV HOME /home/astephen
CMD /usr/bin/firefox
