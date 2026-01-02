#!/usr/bin/env bash
# exit on error
set -o errexit

#install gems
bundle install

#compile assets
bundle exec rake assets:precompile
bundle exec rake assets:clean

#run migrations for production
if [ "$RAILS_ENV" = "production" ]; then
  echo "🟢 Running database migrations..."
  bundle exec rails db:migrate
fi
