#!/bin/sh

if [ ! -f "Dockerfile" ]; then
    echo "no Dockerfile found"
    exit -1
fi

TAG=$(basename $(pwd))
if [ ! -z "$1" ]; then
    TAG=$1
fi
echo $TAG

docker build . --tag $TAG
