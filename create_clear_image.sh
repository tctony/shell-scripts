#!/bin/sh

which convert > /dev/null
if [ $? != 0 ]; then
  echo "convert not found. install imagemagick first!" 
  exit -1
fi

if [ $# != 3 ]; then
  echo "usage $0 width height out.png"
  exit -1
fi 

convert -size $1x$2 xc:none $3
echo "clear image created at $3"