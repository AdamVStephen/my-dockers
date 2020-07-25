FROM ubuntu:18.04

# Recompile git against openssl to avoid TLS errors with some https git servers
# Ref https://stackoverflow.com/questions/52529639/gnutls-recv-error-110-the-tls-connection-was-non-properly-terminated

RUN apt-get update && apt-get install build-essential fakeroot dpkg-dev -y

RUN apt-get install libcurl4-openssl-dev -y

#: Avoid hanging on :tzdata : ref https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
# https://github.com/phusion/baseimage-docker/issues/58
ENV TERM=linux
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
# Not needed, but possibly useful in future.
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata

# Ensure sources are listed
RUN sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y build-dep git

# For reasons unknown, running this again helps.
RUN apt-get install libcurl4-openssl-dev -y


RUN mkdir source-git && cd $_ && apt-get source git && cd git-2.*.*/ && sed -i -- 's/libcurl4-gnutls-dev/libcurl4-openssl-dev/' ./debian/control && sed -i -- '/TEST\s*=\s*test/d' ./debian/rules && dpkg-buildpackage -rfakeroot -b -uc -us 
#RUN cd source-git && dpkg -i ../git_*ubuntu*.deb
RUN cd /root && dpkg -i git_2.*.deb git-man* git-doc*


# Not needed, but possibly useful in future
# Reinstate dialogue should anyone wish to install packages in the docker interactively.
#RUN echo 'debconf debconf/frontend select Dialog' | debconf-set-selections
CMD /bin/bash






