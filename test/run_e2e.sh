#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Starting database container for E2E tests..."
docker-compose up -d db

echo "⏳ Waiting for PostgreSQL to be ready..."
# Give the container a few seconds to fully initialize
sleep 3

echo "🛠️ Preparing the test database..."
bin/rails db:test:prepare

echo "🧪 Running E2E system tests..."
# Turn off 'set -e' temporarily so that if tests fail, the script doesn't abort before cleanup!
set +e
bin/rails test:system
TEST_EXIT_CODE=$?
set -e

echo "🧹 Cleaning up: stopping and removing database container and volumes..."
docker-compose down -v

echo "✅ Cleanup complete!"

# Exit with the tests' exit code so the terminal knows if the tests passed or failed
exit $TEST_EXIT_CODE
