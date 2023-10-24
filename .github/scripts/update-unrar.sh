#!/usr/bin/env bash

UNRAR_URL="https://www.rarlab.com/rar_add.htm"

LAST_VERSION=$(curl ${UNRAR_URL} | egrep "unrarsrc.*UnRAR release source" | sed -e 's|^.*unrarsrc-||' -e 's|.tar.gz.*$||')

if [ "${LAST_VERSION}" ]; then
  sed -i -e "s|UNRAR_VERSION='.*'|UNRAR_VERSION='${LAST_VERSION}'|" Dockerfile*
fi

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update unrar to version: ${LAST_VERSION}"
  git push
fi
