#!/usr/bin/env bash
publish generate
git add --all
git commit -m"new big trip post"
git push
cd ../bigtrip
publish generate
git add --all
git commit -m"new big trip post"
git push