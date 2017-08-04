#!/bin/sh

git add .

DEFAULT_COMMENT_MESSAGE='tmp commit for push dev'

LAST_COMMIT_MESSAGE=`git log -1 --pretty=%B`

if [ "$LAST_COMMIT_MESSAGE" = "$DEFAULT_COMMENT_MESSAGE" ]; then
    git commit --amend -m "$DEFAULT_COMMENT_MESSAGE"
else
    git commit -m "$DEFAULT_COMMENT_MESSAGE"
fi

git push -f dev `git branch | grep \* | cut -d ' ' -f 2`:master
