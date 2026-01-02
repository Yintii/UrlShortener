#!/usr/bin/env bash
# exit on error
set -o errexit

#install gems
bundle install

bundle exec rake db:prepare RAILS_ENV=production

#compile assets
bundle exec rake assets:precompile
bundle exec rake assets:clean
