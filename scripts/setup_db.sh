#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)

METADATA_FILE="$PROJECT_ROOT/scripts/default_metadata.json"

# Read environment variables
dotenv() {
    set -a
    [ -f .env ] && . .env
    set +a
}

dotenv

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
