#!/bin/sh

# create icns file from 1024 png image

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "Input file does not exist"
    exit 1
fi

# Check if the input file is a PNG image
if ! file -b --mime-type "$1" | grep -q '^image/png$'; then
    echo "Input file is not a PNG image"
    exit 1
fi

rm -rf tmp.iconset
mkdir tmp.iconset

# Create the ICNS file
sips -z 16 16 "$1" --out tmp.iconset/icon_16x16.png
sips -z 32 32 "$1" --out tmp.iconset/icon_16x16@2x.png
sips -z 32 32 "$1" --out tmp.iconset/icon_32x32.png
sips -z 64 64 "$1" --out tmp.iconset/icon_32x32@2x.png
sips -z 128 128 "$1" --out tmp.iconset/icon_128x128.png
sips -z 256 256 "$1" --out tmp.iconset/icon_128x128@2x.png
sips -z 256 256 "$1" --out tmp.iconset/icon_256x256.png
sips -z 512 512 "$1" --out tmp.iconset/icon_256x256@2x.png
sips -z 512 512 "$1" --out tmp.iconset/icon_512x512.png
sips -z 1024 1024 "$1" --out tmp.iconset/icon_512x512@2x.png
iconutil -c icns tmp.iconset -o icon.icns

# Clean up the temporary files
rm -rf tmp.iconset
