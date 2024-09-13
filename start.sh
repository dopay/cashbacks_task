#!/bin/bash
set -e

# Wait for the database to be ready
until pg_isready -h db -p 5432 -U postgres
do
  echo "Waiting for postgres..."
  sleep 2;
done

# Create, migrate, and seed the development database
echo "Setting up development database..."
bin/rails db:create db:migrate db:seed RAILS_ENV=development

# Create and migrate the test database
echo "Setting up test database..."
bin/rails db:create db:migrate RAILS_ENV=test

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Start the Rails server
echo "Starting Rails server..."
bundle exec rails server -b 0.0.0.0