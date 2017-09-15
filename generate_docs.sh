#!/bin/bash

jazzy

git add docs/
git add .jazzy.yaml
git commit -m "documentation update"
