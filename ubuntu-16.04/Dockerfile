FROM ubuntu:16.04

# system update
RUN apt-get update && yes | apt-get upgrade -y

# install build dependencies
RUN apt-get install -y build-essential git clang-3.8 wget
RUN ln -s /usr/bin/clang++-3.8 /usr/bin/clang++ && ln -s /usr/bin/clang-3.8 /usr/bin/clang
RUN apt-get install -y '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libssl-dev libxt-dev libvlc-dev libvlccore-dev vlc-nox libudev-dev libusb-1.0-0-dev libxaw7-dev libxrandr-dev libz3-dev libiconv-hook-dev libpng12-dev libjpeg-turbo8-dev libtiff5-dev libfreetype6-dev libxml2-dev libexpat1-dev libicu-dev
RUN apt-get clean && apt-get autoclean
RUN wget https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz && tar xzvf cmake-3.7.2-Linux-x86_64.tar.gz -C /usr/local --strip-components=1

# create buid user and log in
RUN useradd build && cd /home && mkdir build && chown build: build && su build

WORKDIR /home/build

RUN mkdir deps deps/build deps/install/

VOLUME ["/home/build/deps/src/"]

ADD run.sh /home/build/deps/build/run.sh

WORKDIR /home/build/deps/build/

ENV BRANCH dev
ENV BUILD Debug

CMD /home/build/deps/build/run.sh



