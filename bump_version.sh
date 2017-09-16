#!/usr/bin/env bash

# Usage: ./bump_version.sh 3.6.4

if [ "$1" != "" ]; then
    pod spec lint --quick

    sed -i "" "s/\(s.version[ ]*=[ ]\).*/\1 \"$1\"/g" LionheartExtensions.podspec
    sed -i "" "s/tree\/[\.0-9]*/tree\/$1/g" .jazzy.yaml

    sh generate_docs.sh

    git add .
    git commit -m "bump version to $1"

    # Delete tag if already exists
    git tag -d $1
    git push origin master :$1

    git tag $1
    git push origin master
    git push --tags
    pod trunk push
fi
