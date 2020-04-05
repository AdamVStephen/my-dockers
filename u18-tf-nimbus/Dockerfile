FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git python3 python3-venv python3-pip

# Add x11-apps and a browser

RUN apt-get update && apt-get install -y x11-apps firefox

# Add nimbus as a non-privileged user
RUN export uid=1006 gid=1007 && \
	echo "nimbus:x:${uid}:${gid}:nimbus,,,:/home/nimbus:/bin/bash" >> /npuser.txt && \
	echo "nimbus:x:${uid}:${gid}:nimbus,,,:/home/nimbus:/bin/bash" >> /etc/passwd && \
	echo "nimbus:x:${gid}:nimbus" >> /etc/group && \
	mkdir -p /home/nimbus && \
	chown ${uid}:${gid} -R /home/nimbus

USER nimbus
ENV HOME /home/nimbus
CMD /usr/bin/firefox






