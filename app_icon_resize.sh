#!/bin/sh

# 从1024的icon生成App的一套icon

if [ -z "`which magick`" ]; then
    echo 'install imagemagick first!'
    exit -1
fi

if [ "$#" != 1 ]; then
    echo 'usage: ./app_icon_resize icon.png'
fi

convert $1 -resize 180x180 180.png
convert $1 -resize 120x120 120.png
convert $1 -resize 87x87 87.png
convert $1 -resize 80x80 80.png
convert $1 -resize 60x60 60.png
convert $1 -resize 58x58 58.png
convert $1 -resize 40x40 40.png
