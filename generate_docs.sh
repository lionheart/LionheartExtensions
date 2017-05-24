#!/bin/bash

jazzy

git co gh-pages
cp -r docs/* .
rm -rf docs/
git add .
git commit -m "documentation update"
git push origin gh-pages
git co master
