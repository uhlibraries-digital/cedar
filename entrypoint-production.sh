#!/bin/sh

set -e

bundle exec rake jobs:work & >> /dev/null 2>&1
bundle exec rails s -p 3000 -b 0.0.0.0
