FROM ubuntu:18.04

# Required packages

RUN apt-get update && apt-get install -y git make vim python sudo build-essential cmake wget

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

# TODO: Download the HDF5 sources to build from scratch
RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz && \
	tar -zxvf hdf5-1.12.0.tar.gz && \
	sudo mkdir /opt/hdf5-1.12.0-make && \
	mkdir build-hdf5-1.12.0-make && \
	cd build-hdf5-1.12.0-make && \
	../hdf5-1.12.0/configure --prefix=/opt/hdf5-1.12.0-make && \
	make && \
	sudo make install

# Clone some example HDF5 code

RUN cd $HOME && git clone https://github.com/AdamVStephen/hdf5-quickstart.git

# Update PATH to pick up newly installed HDF5 tools

ENV PATH="/opt/hdf5-1.12.0-make/bin:${PATH}"

# Build the example

RUN cd hdf5-quickstart/examples && make all

