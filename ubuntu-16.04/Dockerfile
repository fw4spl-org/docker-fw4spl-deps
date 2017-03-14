FROM ubuntu:16.04
ARG buildtype=Debug

# system update
RUN apt-get update && yes | apt-get upgrade -y

# install build dependencies
RUN apt-get install -y build-essential git g++ wget
RUN apt-get install -y '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libssl-dev libxt-dev libvlc-dev libvlccore-dev libudev-dev libxaw7-dev libxrandr-dev
RUN apt-get clean && apt-get autoclean
RUN wget https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz && tar xzvf cmake-3.7.2-Linux-x86_64.tar.gz -C /usr/local --strip-components=1

# create buid user and log in
RUN useradd build && cd /home && mkdir build && chown build: build && su build

WORKDIR /home/build

# create build tree
RUN mkdir deps deps/src deps/build deps/build/${buildtype} deps/install deps/install/${buildtype}
RUN git clone https://github.com/fw4spl-org/fw4spl-deps.git deps/src/fw4spl-deps
#RUN git clone https://github.com/fw4spl-org/fw4spl-ext-deps.git deps/src/ext-deps

WORKDIR /home/build/deps/src/fw4spl-deps

RUN git checkout dev

# configure
WORKDIR /home/build/deps/build/${buildtype}

RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/build/deps/install/${buildtype} -DCMAKE_BUILD_TYPE:STRING="${buildtype}" -DARCHIVE_DIR:PATH=/home/build/deps/build/archive -DENABLE_OPEN_MP:BOOL=ON -DENABLED_OGRE_DEPS:BOOL=ON -D ENABLED_PCL_DEPS:BOOL=ON -DENABLED_REALSENSE:BOOL=ON -DENABLED_SOFA_DEPS:BOOL=ON -DENABLE_ODIL:BOOL=ON -DENABLE_PTAM:BOOL=ON -DENABLE_OPENCV_CONTRIB:BOOL=ON /home/build/deps/src/fw4spl-deps

WORKDIR /home/build/deps/build/${buildtype}

CMD make -j`grep processor -c /proc/cpuinfo` && make package


