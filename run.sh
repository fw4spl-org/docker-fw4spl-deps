#!/bin/bash

if [ ! -d "/home/build/deps/src/f4s-deps" ]; then
    echo "Cloning fw4spl-deps repos"
    git clone https://github.com/fw4spl-org/fw4spl-deps.git /home/build/deps/src/f4s-deps
    cd /home/build/deps/src/f4s-deps
    git fetch origin $BRANCH && git checkout $BRANCH
fi

if [ ! -d "/home/build/deps/src/ext-deps" ]; then
    echo "Cloning fw4spl-ext-deps repos"
    git clone https://github.com/fw4spl-org/fw4spl-ext-deps.git /home/build/deps/src/ext-deps
    cd /home/build/deps/src/ext-deps
    git fetch origin $BRANCH && git checkout $BRANCH
fi

echo "Updating repos"

cd /home/build/deps/src/f4s-deps

git checkout $BRANCH

cd /home/build/deps/src/ext-deps

git checkout $BRANCH

echo "Configure"
mkdir -p /home/build/deps/build/${BUILD}

cd /home/build/deps/build/${BUILD}

cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/build/deps/install/${BUILD} -DCMAKE_BUILD_TYPE:STRING="${BUILD}" -DCMAKE_C_COMPILER:PATH=/usr/bin/clang-3.8 -DCMAKE_CXX_COMPILER:PATH=/usr/bin/clang++-3.8 -DARCHIVE_DIR:PATH=/home/build/deps/build/archive -DADDITIONAL_DEPS:PATH=/home/build/deps/src/ext-deps -DENABLE_OPEN_MP:BOOL=ON -DENABLED_OGRE_DEPS:BOOL=ON -D ENABLED_PCL_DEPS:BOOL=ON -DENABLED_REALSENSE:BOOL=ON -DENABLED_SOFA_DEPS:BOOL=ON -DENABLE_ODIL:BOOL=ON -DENABLED_BUILD_PTAM:BOOL=ON -DENABLED_BUILD_ORB_SLAM2:BOOL=OFF -DENABLE_OPENCV_CONTRIB:BOOL=ON /home/build/deps/src/f4s-deps

echo "Build"
make -j`grep processor -c /proc/cpuinfo` && make package
