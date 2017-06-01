#!/bin/bash

if [ ! -d "/home/build/fw4spl/.git" ]; then
    echo "Empty git repository, you must provide a valid path or clone the repository with the following command:"
    echo "git clone ssh://<login>@git.debian.org/git/debian-med/fw4spl.git fw4spl"
    echo "cd fw4spl"
    echo "git checkout -b upstream origin/upstream && git checkout -b pristine-tar origin/pristine-tar && git checkout master"
fi

zsh

