#!/bin/bash

jazzy \
  --author Lionheart \
  --author_url http://lionheartsw.com \
  --github_url https://github.com/lionheart/LionheartExtensions \
  --github-file-prefix https://github.com/lionheart/LionheartExtensions/tree/3.3.0 \
  --module LionheartExtensions

git co gh-pages
cp -r docs/* .
rm -rf docs/
git add .
git commit -m "documentation update"
git co master
