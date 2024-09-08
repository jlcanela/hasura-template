#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)

# Read environment variables
dotenv() {
    set -a
    [ -f .env ] && . .env
    set +a
}

dotenv

# Apply the migration
echo "Applying migration..."
hasura migrate apply --database-name default --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET"

# Reload metadata to reflect the changes
echo "Reloading metadata..."
hasura metadata apply --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET"

echo "Migration applied and metadata reloaded."
