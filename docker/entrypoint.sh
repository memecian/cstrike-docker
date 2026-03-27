#!/usr/bin/env sh

if [ -d /tmp/gamedir ]
then
  rsync --chown=steam:steam /tmp/gamedir/* /opt/steam/cstrike/
fi

export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"

echo "Starting CS 1.6 Docker ${VERSION} (${RELEASE_DATE})..."
./hlds_linux "${@}"
