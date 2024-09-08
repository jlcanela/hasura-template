#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)

# Read environment variables
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env" | xargs)
else
    echo ".env file not found in project root. Please run init.sh first."
    exit 1
fi

# Apply the migration
echo "Applying migration..."
hasura migrate apply --database-name default --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET"

# Reload metadata to reflect the changes
echo "Reloading metadata..."
hasura metadata apply --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET"

echo "Migration applied and metadata reloaded."
