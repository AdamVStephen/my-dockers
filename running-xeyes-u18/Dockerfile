# Recipe from fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

FROM ubuntu:18.04

# Install x11-apps to get xeyes
RUN apt-get update && apt-get -y install x11-apps firefox

RUN export uid=1006 gid=1007 && \
 	mkdir -p /home/astephen  && \
 	echo "astephen:x:${uid}:${gid}:Developer,,,:/home/astephen:/bin/bash" >> /etc/passd && \
 	echo "astephen:x:${gid}:astephen" >> /etc/group && \
 	chown ${uid}:${gid} -R /home/astephen

# No /etc/sudoers.d in 18.04
# 	echo "astephen ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/astephen && \
# 	chmod 0440 /etc/sudoers.d/astephen && \


USER astephen
ENV HOME /home/astephen
#CMD /usr/bin/firefox
