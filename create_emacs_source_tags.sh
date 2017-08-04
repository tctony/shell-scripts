#!/bin/sh
# generate gtags in .tags/emacs-lisp for lisp sources contained in emacs

if [ $# == 0 ]; then
    echo "Usage: create_emacs_tags.sh source_dir"
    echo "the source_dir might be like /usr/local/Cellar/emacs-plus/25.2_1/share/emacs/25.2/lisp/"
    exit -1;
fi

SOURCE_DIR=$1
TAG_DIR=~/.tags/emacs-lisp-sources/

rm -rf $TAG_DIR
mkdir -p $TAG_DIR

rsync -r --include '*/' --include '*.el.gz' --exclude '*' $SOURCE_DIR $TAG_DIR

pushd $TAG_DIR > /dev/null
find . -type f -name "*.el.gz" -exec gzip -d \{\} +
gtags --gtagslabel=ctags
popd > /dev/null

ln -sfh ~/Library/Caches/Homebrew/emacs-plus--git ~/.tags/emacs-c-sources > /dev/null
