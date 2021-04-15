#!/usr/bin/env bash

PAR2_URL="https://api.github.com/repos/sabnzbd/sabnzbd/tags"


LAST_VERSION=$(curl -SsL ${PAR2_URL} | jq .[0].name -r )

sed -i -e "s|PAR2CMDLINE_VERSION='.*'|PAR2CMDLINE_VERSION='${LAST_VERSION}'|" Dockerfile_*

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update par2cmdline to version: ${LAST_VERSION}"
  git push
fi
