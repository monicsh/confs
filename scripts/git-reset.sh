# !/bin/sh

#

if [[ $# -lt 1 ]]; then
    DEV_BRANCH=dev
else
    DEV_BRANCH=$1
    shift 1
fi

echo "Using branch:$DEV_BRANCH"
git co $DEV_BRANCH && git pull && git co -- . && git pruneall

echo "done"
