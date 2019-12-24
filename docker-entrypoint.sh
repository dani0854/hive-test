#!/bin/bash
set -ex

if [ "$1" = 'hiveserver2' ]; then
  schematool --dbType postgres --initSchema
fi

exec "$@"
