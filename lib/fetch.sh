#!/bin/bash

DIR=`pwd`
source $DIR/lib/config.conf

cp $DIR/lib/SUMMARY.md $DIR/src/SUMMARY.md

for repo in "${repos[@]}";
do
    NAME=$(echo ${repo} | egrep -o '[^\/]*$' )
    NAME=${NAME/.git/}
    REPO_DOCS=$DIR/src/$NAME

    git clone $repo $NAME
    rm -rf $REPO_DOCS
    mv $DIR/$NAME/$docs_dir $REPO_DOCS
    rm -rf $NAME
 
    if [ -f "$REPO_DOCS/SUMMARY.md" ]
    then
        while IFS= read link || [[ -n "$link" ]]
        do
            link=${link/](/]($NAME/}
            echo "${link}" >> $DIR/src/SUMMARY.md
        done < $REPO_DOCS/SUMMARY.md
    fi
done

