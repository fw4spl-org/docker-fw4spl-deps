This repository contains Dockerfile to build **FW4SPL** dependencies for our supported platforms.

Currently you can build images for Mint, Ubuntu and Debian, more to come.

You must have docker installed on your host computer. Then to build an image, for instance ubuntu 16.04, run something like:
```
cd ubuntu-16.04
docker build . -t myName/fw4spl-ubuntu-16.04
```
