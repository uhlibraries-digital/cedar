#!/bin/sh

set -e

rm -f /cedar-app/tmp/pids/server.pid

bundle exec rails s -p 3000 -b 0.0.0.0
