FROM debian:stable-slim

# Ref: https://tomassetti.me/antlr-mega-tutorial

# Update repositories and install minimal tools
RUN apt-get -y update && apt-get -y install default-jre default-jdk git wget vim python3 python3-pip

# Antlr runtime for python3
RUN pip install antlr4-python3-runtime

# Download the antlr sources 
WORKDIR /root/dev

RUN wget https://www.antlr.org/download/antlr-4.9.3-complete.jar

