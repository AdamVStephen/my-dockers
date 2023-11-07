FROM debian:buster-20231030-slim

# Buster aka Debian 10 EOL 10/09/2022  Official docker image for buster slim dated Oct 2023 still available.
# Create a non-privileged user for MARTe development

RUN export uid=1006 gid=1007 && \
	echo "marte-dev:x:${uid}:${gid}:marte-dev,,,:/home/marte-dev:/bin/bash" >> /npuser.txt && \
	echo "marte-dev:x:${uid}:${gid}:marte-dev,,,:/home/marte-dev:/bin/bash" >> /etc/passwd && \
	echo "marte-dev:x:${gid}:marte-dev" >> /etc/group && \
	mkdir -p /home/marte-dev && \
	chown ${uid}:${gid} -R /home/marte-dev

USER marte-dev
ENV HOME /home/marte-dev

# Grab a copy of the cint sources.
#RUN wget https://github.com/AdamVStephen/cint/archive/master.zip

# Extract the MARTe source code
#RUN mkdir -p /home/marte-dev/MARTe/MARTe-1.0/toomanych
#RUN echo "Damien Karkinsky integrated MARTe 1.0 sources from 2019" >> /home/marte-dev/MARTe/MARTe-1.0/README.md
#RUN echo "cloned from github via git clone http://github.com/toomanych/MARTe1" >> /home/marte-dev/MARTe/MARTe-1.0/README.md
#RUN cd /home/marte-dev/MARTe/MARTe-1.0/toomanych && git clone http://github.com/toomanych/MARTe1

CMD /bin/bash





