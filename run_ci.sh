#!/usr/bin/env bash
set -e
rm -f Gemfile.lock
bundle install
METRICS=1 bundle exec rspec spec
