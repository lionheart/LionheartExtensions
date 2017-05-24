#!/bin/bash

jazzy \
  --author "Lionheart Software" \
  --author_url http://lionheartsw.com \
  --github_url https://github.com/lionheart/LionheartExtensions \
  --github-file-prefix https://github.com/lionheart/LionheartExtensions/tree/3.4.1

git co gh-pages
cp -r docs/* .
rm -rf docs/
git add .
git commit -m "documentation update"
git co master
