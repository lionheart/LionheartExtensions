#!/bin/bash

if [ "$1" != "" ]; then
  sed -i "" "s/\(s.version[ ]*=[ ]\).*/\1 \"$1\"/g" LionheartExtensions.podspec
  sed -i "" "s/tree\/[\.0-9]*/tree\/$1/g" generate_docs.sh
  sed -i "" "s/module-version [\.0-9]*/module-version $1/g" generate_docs.sh
  git add .
  git commit -m "bump version to $1"
  git tag $1
  git push origin master
  git push --tags
  pod trunk push
fi
