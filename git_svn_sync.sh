#! /bin/sh
# Sync git ( release branch) to svn (master branch)

# last synced commit
LAST_SYNC=$(cat .LAST_SYNC 2>/dev/null);
if [ -z $LAST_SYNC ]; then
    echo "can't get last synced commit from .LAST_SYNC, please set it."
    exit -1
fi

# current commit on release
CURRENT=$(git rev-list --max-count=1 release)

if [ $LAST_SYNC = $CURRENT ]; then
    echo "no new commits found."
    exit 0
fi

# find commits that need to be synced
echo "find commits to sync:"
echo
git rev-list $LAST_SYNC...$CURRENT --pretty=medium 2>/dev/null
if [ $? != 0 ]; then
   echo "can't find last commit ${LAST_SYNC} on release."
   exit -1
fi
echo

# switch to master
git diff-index --quiet HEAD
if [ $? != 0 ]; then
   echo "found stage commit, save your work first please."
   exit -1
fi
git checkout master

# merge commits
git cherry-pick $LAST_SYNC...$CURRENT

if [ $? != 0 ]; then
    echo "merge commit failed."
    exit -1
fi

echo $CURRENT > .LAST_SYNC

echo "sync commits to svn..."
git svn rebase && git svn dcommit

if [ $? != 0 ]; then
    exit -1
fi

# back to release branch
git checkout release
echo "\ndone"
