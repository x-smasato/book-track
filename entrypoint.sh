#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /rails/tmp/pids/server.pid

# Check if Gemfile.lock has changed and run bundle install if needed
if [ ! -f /usr/local/bundle/.last_bundle_checksum ] || \
   [ "$(md5sum /rails/Gemfile.lock | cut -d ' ' -f 1)" != "$(cat /usr/local/bundle/.last_bundle_checksum)" ]; then
  echo "Gemfile.lock has changed. Running bundle install..."
  bundle install
  md5sum /rails/Gemfile.lock | cut -d ' ' -f 1 > /usr/local/bundle/.last_bundle_checksum
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile)
exec "$@"
