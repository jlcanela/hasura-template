#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)

METADATA_FILE="$PROJECT_ROOT/scripts/default_metadata.json"

# Read environment variables
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env" | xargs)
else
    echo ".env file not found in project root. Please create one with HASURA_GRAPHQL_ADMIN_SECRET."
    exit 1
fi

# Restore Hasura metadata
echo "Restoring/Replacing Hasura metadata..."
curl -d"{\"type\": \"replace_metadata\", \"args\": $(cat $METADATA_FILE)}" \
     -H "X-Hasura-Admin-Secret: $HASURA_GRAPHQL_ADMIN_SECRET" \
     -H "Content-Type: application/json" \
     "$HASURA_ENDPOINT/v1/metadata"

# Check if the curl command was successful
if [ $? -eq 0 ]; then
    echo "Metadata applied successfully."
else
    echo "Failed to apply metadata. Please check your Hasura endpoint and admin secret."
fi
