#!/usr/bin/env bash

SABNZBD_URL="https://api.github.com/repos/sabnzbd/sabnzbd/tags"

LAST_VERSION=$(curl -SsL ${SABNZBD_URL} | jq .[0].name -r )

sed -i -e "s|SABNZBD_VERSION='.*'|SABNZBD_VERSION='${LAST_VERSION}'|" Dockerfile*

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update to version: ${LAST_VERSION}"
  git push
fi
