FROM ubuntu:18.04

# Required packages

RUN apt-get update && apt-get install -y git make vim python sudo build-essential hdf5-tools libhdf5-dev cmake

# Add hdf5dev as a non-privileged user

#RUN export uid=1006 gid=1007 && \
#	echo "hdf5dev:x:${uid}:${gid}:astephen,,,:/home/astephen:/bin/bash" >> /npuser.txt && \
#	echo "hdf5dev:x:${uid}:${gid}:astephen,,,:/home/astephen:/bin/bash" >> /etc/passwd && \
#	echo "hdf5dev:x:${gid}:astephen" >> /etc/group && \
#	mkdir -p /home/hdf5dev && \
#	chown ${uid}:${gid} -R /home/hdf5dev

RUN adduser --disabled-password --gecos '' hdf5dev && \
	echo "hdf5dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/hdf5dev && \
	chmod 0440 /etc/sudoers.d/hdf5dev

# Grant hdf5dev user sudo privilege to test apt install commands
# CAVEAT : if new packages required, then make an updated Dockerfile to latch these.

RUN usermod -aG sudo hdf5dev

USER hdf5dev
ENV HOME /home/hdf5dev
CMD /bin/bash

WORKDIR /home/hdf5dev

# Clone some example HDF5 code

RUN git clone https://github.com/AdamVStephen/hdf5-quickstart.git




