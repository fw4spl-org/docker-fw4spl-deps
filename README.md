This repository contains Dockerfile to build **FW4SPL** dependencies for our supported platforms.

Currently you can build images for Mint, Ubuntu and Debian. The image contains a system with all the libraries and tools necessary to build **FW4SPL** dependencies. Running the container launches the compilation and produces an archive with portable binaries. Last, note that the Dockerfile and the compilation script can simply be used as a source of documentation.

In order to build the image, you must have **docker** installed on your host computer. Then to build an image, for instance ubuntu 16.04, run something like:
```
docker build -f ubuntu-16.04/Dockerfile . -t myName/fw4spl-ubuntu-16.04
```

Then you can build the dependencies by running a container from the previous built image. Note that the source tree is not stored inside the container, so must provide a path on your host system to fill the volume `/home/build/deps/src`. If the actual source tree is empty, the compilation script will clone everything for you, so if you don't have a existing tree, just provide a new path with write access.

Optionally you can specify the build type with the environment variable `BUILD`, which is **Debug** by default. This value will be passed to the [CMAKE_BUILD_TYPE](https://cmake.org/cmake/help/v3.7/variable/CMAKE_BUILD_TYPE.html) variable, so you must provide a valid string like **Debug** or **Release** starting with a capital. You can also provide the branch you want to checkout with the environment variable `BRANCH` (**master** by default).

```
docker run -v /home/myName/fw4spl/deps/src:/home/build/deps/src -e BRANCH=dev -e BUILD=Debug -t myName/fw4spl-ubuntu-16.04
```

At the end, if the build is successful you should see something like:

```
Run CPack packaging tool...
CPack: Create package using TGZ
CPack: Install projects
CPack: - Run preinstall target for: BinPkgs
CPack: - Install project: BinPkgs
Fix VTK CMake export files...
Fix DCMTK CMake export files...
Fix PCL CMake export files...
CPack: Create package
CPack: - package: /home/build/deps/build/debug/BinPkgs-Debug-11.0.6-Linux.tar.gz generated.
```

You can then retrieve your packages from your container. First get the name of your container, so list the containers:

```
# docker ps -a
CONTAINER ID        IMAGE                                  COMMAND                  CREATED             STATUS                      PORTS               NAMES
0fce25f24df2        fbridault/fw4spl-ubuntu-16.04          "/bin/sh -c 'make -j1"   41 minutes ago      Exited (0) 48 seconds ago                       romantic_mahavira
```

And then copy your package to some place:

```
# docker cp romantic_mahavira:/home/build/deps/build/Debug/BinPkgs-Debug-11.0.6-Linux.tar.gz /some/place
```
