#!/usr/bin/env bash

. /etc/profile
. /usr/local/bin/docker-entrypoint-functions.sh

MYUSER="${APPUSER}"
MYGID="${APPGID}"
MYUID="${APPUID}"

AutoUpgrade
ConfigureUser

if [ "${1}" == 'sabnzbd' ]; then
  DockLog "fix permissions on /config and /opt/sabnzbd"
  chown -R "${MYUSER}":"${MYUSER}" /config /opt/sabnzbd
  chmod -R g+w /config /opt/sabnzbd

  RunDropletEntrypoint

  DockLog "Starting app: ${1}"
  exec su-exec "${MYUSER}" python /opt/sabnzbd/SABnzbd.py -s 0.0.0.0:8080 --config-file=/config/sabnzbd.ini
else
  exec "$@"
fi

