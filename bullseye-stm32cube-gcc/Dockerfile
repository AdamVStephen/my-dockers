FROM debian:stable-slim

# Update repositories and install minimal tools
RUN apt-get -y update && apt-get -y install gcc-arm-none-eabi binutils-arm-none-eabi

# Optional libraries and debuggers
RUN apt-get -y install openocd gdb-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib

# Essential
RUN apt-get -y install git make wget unzip vim

# Clone sources from Infinnovation
WORKDIR /root/dev

# 
RUN git clone https://github.com/infinnovation-dev/stm32cube-gcc

WORKDIR /root/dev/stm32cube-gcc

# TODO: update gitflow branches upstream
#RUN git checkout develop

# Download the most recent STM32Cube version from the ST website and extract to cube
RUN make cube

# Copy a simple example/template, startup code and linker script from cube/ to src/
RUN make template

# Uncomment the #define USE_NUCLEO_64 in stm32g4xx_nucleo_conf.h
# Too cute ?
RUN sed -i '/USE_NUCLEO_64/s/\/\*//g;/USE_NUCLEO_64/s/\*\///g' src/stm32g4xx_nucleo_conf.h

# Build the target ELF binary : other targets support flashing a target and debugging it.
RUN make all
