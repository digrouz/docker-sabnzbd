#!/usr/bin/env bash

PAR2_URL="https://api.github.com/repos/animetosho/par2cmdline-turbo/releases"

FULL_LAST_VERSION=$(curl -SsL ${PAR2_URL} | \
              jq -r -c '.[] | select( .prerelease == false ) | .tag_name' |\
              head -1 \
              )
LAST_VERSION="${FULL_LAST_VERSION}"
LAST_VERSION="master"

if [ "${LAST_VERSION}" ]; then
  sed -i -e "s|PAR2CMDLINE_VERSION='.*'|PAR2CMDLINE_VERSION='${LAST_VERSION}'|" Dockerfile*
fi

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update par2cmdline to version: ${LAST_VERSION}"
  git push
fi
