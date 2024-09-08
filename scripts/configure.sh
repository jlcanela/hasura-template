#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)
SCRIPTS_DIR="$PROJECT_ROOT/scripts"

# Read environment variables
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env" | xargs)
else
    echo ".env file not found in project root. Please run init.sh first."
    exit 1
fi

# Function to generate a random string
generate_random_string() {
    openssl rand -base64 24 | tr -d "=+/" | cut -c1-24
}

# Create .env file from template
echo "Creating .env file..."
cp "$SCRIPTS_DIR/.env-template" "$PROJECT_ROOT/.env"

# Generate and set random passwords
sed -i "s/^POSTGRES_PASSWORD=$/POSTGRES_PASSWORD=$(generate_random_string)/" "$PROJECT_ROOT/.env"
sed -i "s/^HASURA_GRAPHQL_ADMIN_SECRET=$/HASURA_GRAPHQL_ADMIN_SECRET=$(generate_random_string)/" "$PROJECT_ROOT/.env"

echo ".env file created with random passwords."

# Read the admin secret from the newly created .env file
ADMIN_SECRET=$(grep HASURA_GRAPHQL_ADMIN_SECRET "$PROJECT_ROOT/.env" | cut -d '=' -f2)

# Create config.yml file
echo "Creating Hasura config.yml file..."
cat << EOF > "$PROJECT_ROOT/config.yaml"
version: 3
endpoint: $HASURA_ENDPOINT
admin_secret: $ADMIN_SECRET
metadata_directory: metadata
actions:
  kind: synchronous
  handler_webhook_baseurl: http://localhost:3000
EOF

echo "Hasura config.yml file has been created in $PROJECT_ROOT"
