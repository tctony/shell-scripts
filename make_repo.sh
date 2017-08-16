#!/bin/sh

if [ $# = 0 ]; then
    echo 'Usage: make_repo.sh dir/path/to/repo';
    exit -1;
fi

mkdir -p $1

pushd $1 >/dev/null

git init >/dev/null
git config receive.denyCurrentBranch updateInstead

popd >/dev/null
