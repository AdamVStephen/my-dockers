FROM ubuntu:18.04

# Add astephen as a non-privileged user

RUN apt-get update && apt-get install -y x11-apps firefox

RUN export uid=1006 gid=1007 && \
	echo "astephen:x:${uid}:${gid}:astephen,,,:/home/astephen:/bin/bash" >> /npuser.txt && \
	echo "astephen:x:${uid}:${gid}:astephen,,,:/home/astephen:/bin/bash" >> /etc/passwd && \
	echo "astephen:x:${gid}:astephen" >> /etc/group && \
	mkdir -p /home/astephen && \
	chown ${uid}:${gid} -R /home/astephen

USER astephen
ENV HOME /home/astephen
CMD /usr/bin/firefox






