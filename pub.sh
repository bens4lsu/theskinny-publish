#!/usr/bin/env bash

publish generate
git add --all
git commit -m "$1"
git push
