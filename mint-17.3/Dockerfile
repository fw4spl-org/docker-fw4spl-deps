FROM cdbishop89/linux-mint-17.3:latest
ARG buildtype=Debug
ARG branch=dev

# modemmanager causes troubles on update because upstart is not there
# of course this is *specific* to the docker image so don't do that on a real install !
RUN rm /var/lib/dpkg/info/modemmanager.* && dpkg --remove --force-remove-reinstreq modemmanager

# change default mirrors - this is for now hardcoded for a location near France or Germany
# you may want to comment this out or adapt to you own location
RUN sed -i 's!packages.linuxmint.com!ftp-stud.hs-esslingen.de/pub/Mirrors/packages.linuxmint.com!' /etc/apt/sources.list.d/official-package-repositories.list && sed -i 's!archive.ubuntu.com/ubuntu!bouyguestelecom.ubuntu.lafibre.info/ubuntu!' /etc/apt/sources.list.d/official-package-repositories.list

# system update
RUN apt-get update && apt-get install -y mint-mirrors mintsources mintupdate && apt-get update && yes | apt-get upgrade -y

# install build dependencies
RUN apt-get install -y build-essential git clang-3.8
RUN ln -s /usr/bin/clang++-3.8 /usr/bin/clang++ && ln -s /usr/bin/clang-3.8 /usr/bin/clang
RUN apt-get install -y '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libssl-dev libxt-dev libvlc-dev libvlccore-dev libudev-dev libxaw7-dev libxrandr-dev
RUN apt-get clean && apt-get autoclean
RUN wget https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz && tar xzvf cmake-3.7.2-Linux-x86_64.tar.gz -C /usr/local --strip-components=1

# create buid user and log in
RUN useradd build && cd /home && mkdir build && chown build: build && su build

WORKDIR /home/build

# create build tree
RUN mkdir deps deps/src deps/build deps/build/${buildtype} deps/install deps/install/${buildtype}
RUN git clone https://github.com/fw4spl-org/fw4spl-deps.git deps/src/fw4spl-deps
RUN git clone https://github.com/fw4spl-org/fw4spl-ext-deps.git deps/src/ext-deps

WORKDIR /home/build/deps/src/fw4spl-deps

RUN git checkout $branch

# configure
WORKDIR /home/build/deps/build/${buildtype}

RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/build/deps/install/${buildtype} -DCMAKE_BUILD_TYPE:STRING="${buildtype}" -DCMAKE_C_COMPILER:PATH=/usr/bin/clang-3.8 -DCMAKE_CXX_COMPILER:PATH=/usr/bin/clang++-3.8 -DARCHIVE_DIR:PATH=/home/build/deps/build/archive -DADDITIONAL_DEPS:PATH=/home/build/deps/src/ext-deps -DENABLE_OPEN_MP:BOOL=ON -DENABLED_OGRE_DEPS:BOOL=ON -D ENABLED_PCL_DEPS:BOOL=ON -DENABLED_REALSENSE:BOOL=ON -DENABLED_SOFA_DEPS:BOOL=ON -DENABLE_ODIL:BOOL=ON -DENABLE_PTAM:BOOL=ON -DENABLE_OPENCV_CONTRIB:BOOL=ON /home/build/deps/src/fw4spl-deps

WORKDIR /home/build/deps/build/${buildtype}

CMD make -j`grep processor -c /proc/cpuinfo` && make package


