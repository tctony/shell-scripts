#!/bin/sh

# 从1024的icon生成App的一套icon

if [ -z "`which magick`" ]; then
    echo 'install imagemagick first!'
    exit -1
fi

if [ $# -lt 1 ]; then
    echo 'usage: app_icon_resize.sh icon_file [mac|tray|ios]'
    exit -1
fi

if [ ! -f "$1" ]; then
    echo 'icon file not exist!'
    exit -1
fi

if [ "$2" = "mac" ]; then
    # mac
    convert $1 -resize 1024x1024 1024.png
    convert $1 -resize 512x512 512.png
    convert $1 -resize 256x256 256.png
    convert $1 -resize 128x128 128.png
    convert $1 -resize 64x64 64.png
    convert $1 -resize 32x32 32.png
    convert $1 -resize 16x16 16.png
    exit 0
elif [ "$2" = "tray" ]; then
    # mac tray icon
    convert $1 -resize 48x48 48.png
    convert $1 -resize 32x32 32.png
    convert $1 -resize 16x16 16.png
    exit 0
elif [ "$2" = "ios" ]; then
    # fall through
    sleep 0
fi

# ios
convert $1 -resize 1024x1024 1024.png
convert $1 -resize 512x512 512.png
convert $1 -resize 180x180 180.png
convert $1 -resize 167x167 167.png
convert $1 -resize 152x152 152.png
convert $1 -resize 120x120 120.png
convert $1 -resize 87x87 87.png
convert $1 -resize 80x80 80.png
convert $1 -resize 76x76 76.png
convert $1 -resize 60x60 60.png
convert $1 -resize 58x58 58.png
convert $1 -resize 40x40 40.png
convert $1 -resize 29x29 29.png
