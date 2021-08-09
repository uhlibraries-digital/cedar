#!/bin/sh

set -e

echo "ENVIRONMENT: $RAILS_ENV"

bundle check || bundle install

rm -f $APP_PATH/tmp/pids/server.pid

bundle exec ${@}