#!/bin/bash

if [ "$1" != "" ]; then
  sed "s/\(s.version[ ]*=[ ]\).*/\1 \"$1\"/g" LionheartExtensions.podspec
  git add .
  git commit -m "bump version to $1"
  git tag $1
fi
