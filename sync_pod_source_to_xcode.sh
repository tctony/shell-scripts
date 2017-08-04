#!/bin/sh
# sync_pod_source_to_xcode.sh '/path/to/lib/source_dir' '/path/to/project/Pods/lib'

if [ $# != 2 ]; then
    echo "sync_pod_source_to_xcode.sh '/path/to/lib/source_dir' '/path/to/project/Pods/lib'"
fi

source_path=$1
pod_path=$2

cd $source_path && cd ..
source_dir_name=`basename $source_path`
for f in $(find $source_dir_name -name '*.[h,m]');
do
    fp=$pod_path/$f
    if [ -e $fp ]; then
        diff -q $fp $f
        if [ $? != 0 ]; then
            opendiff $fp $f -merge $fp
        fi
    else
        read -r -p "\"$f\" was not found. Copy it? [y/N]" answer
        case "$answer" in
            [yY][eE][sS]|[yY]) 
                cp $f $fp
                ;;
            *)
                ;;
        esac
    fi
done


