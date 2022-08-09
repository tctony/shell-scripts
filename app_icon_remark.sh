#!/bin/sh

# 基于1024x1024的icon，生成右下角带标记的icon

if [ -z "`which magick`" ]; then
    echo 'install imagemagick first!'
    exit -1
fi

if [ "$#" != 4 ]; then
    echo 'usage: ./app_icon_remark.sh icon.png mark_text red|black icon_remarked.png';
    exit -1
fi

convert -size 1024x1024 xc:none \
       -fill $3 \
       -draw "path 'M 512,1024 L 1024,512 1024,754 754,1024'" \
       mark_bg.png
convert -size 553x242 -background none \
        -fill white \
        -font "/Library/Fonts/Microsoft/SimHei.ttf" \
        -pointsize 178 \
        -gravity center \
        label:"$2" \
        -rotate -45 \
        mark_text.png
convert "$1" -size 1024x1014 \
        mark_bg.png -composite \
        mark_text.png -geometry +548+548 -composite \
        "$4"

rm -f mark_bg.png
rm -f mark_text.png
