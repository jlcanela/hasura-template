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

# Refresh metadata files in 'metadata folder'
echo "Refreshing metadata..."
hasura metadata export --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET"
#hasura seed apply --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET" --database-name default

echo "Metadata are refreshed."
