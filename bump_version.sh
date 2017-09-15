#!/usr/bin/env bash

if [ "$1" != "" ]; then
    pod spec lint --quick

    sed -i "" "s/\(s.version[ ]*=[ ]\).*/\1 \"$1\"/g" LionheartExtensions.podspec
    sed -i "" "s/tree\/[\.0-9]*/tree\/$1/g" .jazzy.yaml

    jazzy

    git add docs/
    git add .jazzy.yml
    git commit -m "documentation update"

    git add .
    git commit -m "bump version to $1"

    # git tag $1
    # git push origin master
    # git push --tags
    # pod trunk push

    # sync_directory_to_s3 "us-east-2" "lionheart-opensource" "E33XE7TKGUV1ZD" "docs" "LionheartExtensions"
fi
