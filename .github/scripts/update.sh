#!/usr/bin/env bash

SABNZBD_URL="https://api.github.com/repos/sabnzbd/sabnzbd/releases"

FULL_LAST_VERSION=$(curl -SsL ${SABNZBD_URL} | \
              jq -r -c '.[] | select( .prerelease == false ) | .tag_name' |\
              head -1 \
              )
LAST_VERSION="${FULL_LAST_VERSION}"

sed -i -e "s|SABNZBD_VERSION='.*'|SABNZBD_VERSION='${LAST_VERSION}'|" Dockerfile*

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update to version: ${LAST_VERSION}"
  git push
fi
