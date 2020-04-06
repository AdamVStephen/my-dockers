FROM ubuntu:18.04

RUN apt-get update && apt-get install -y git python3 python3-virtualenv python3-venv python3-pip

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

# Set up the requisite python environment for tensorflow
#
# To activate a virtual python environment from a Docker file is slightly non-trivial.
# Ref https://pythonspeed.com/articles/activate-virtualenv-dockerfile/
#
# Naive approach fails because every RUN directive is a different process (no shared state)
#
# One option is to path everything from venv/bin (mostly works)
# One option is RUN . /venv/bin/active && other commands here (but repeat on every occurence)
# Elegant solution is to do what activate does, at the ENV level for all dockerised commands

WORKDIR /home/nimbus
ENV VENV_NAME=ubuntu18-python3.6-tensorflow
ENV VIRTUAL_ENV=/home/nimbus/$VENV_NAME
RUN python3 -m virtualenv --python=/usr/bin/python3 $VIRTUAL_ENV

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN python -m pip install --upgrade pip setuptools
COPY requirements.txt /home/nimbus/requirements.txt
RUN pip install -r requirements.txt

CMD /usr/bin/bash






