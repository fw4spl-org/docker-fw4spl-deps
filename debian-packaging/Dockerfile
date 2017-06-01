FROM debian:unstable

# system update
RUN apt-get update && yes | apt-get install -y \
 git \
 build-essential \
 quilt \
 git-buildpackage \
 zsh \
 cmake \
 vim

# install fw4spl dependencies
RUN apt-get install -y debhelper libboost-all-dev zlib1g-dev libexpat1-dev libpng-dev libtiff5-dev libcppunit-dev libhdf5-dev libqt5opengl5-dev libqt5x11extras5-dev qttools5-dev libvtk6-dev libgdcm2-dev libinsighttoolkit4-dev libann-dev libvtkgdcm2-dev libvtk6.3-qt libvtk6-qt-dev libcamp0.7-dev libglm-dev xvfb xauth dbus-x11 rdfind symlinks

RUN apt-get clean && apt-get autoclean

# create buid user and log in
RUN useradd build && usermod -s /bin/zsh build

WORKDIR /home/build

ADD quiltrc /home/build/.quiltrc
ADD zshrc /home/build/.zshrc
ADD zsh-git-prompt-master /home/build/zsh-git-prompt-master/

ADD run.sh /home/build/run.sh

RUN chown -R build: /home/build/

USER build

# Bind source tree
VOLUME ["/home/build/fw4spl"]

WORKDIR /home/build/fw4spl

CMD /home/build/run.sh

