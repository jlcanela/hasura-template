#!/bin/bash

# Function to generate a random string
generate_random_string() {
    openssl rand -base64 24 | tr -d "=+/" | cut -c1-24
}

# Copy the template to .env
cp .env-template .env

# Generate and set random passwords
sed -i "s/^POSTGRES_PASSWORD=$/POSTGRES_PASSWORD=$(generate_random_string)/" .env
sed -i "s/^HASURA_GRAPHQL_ADMIN_SECRET=$/HASURA_GRAPHQL_ADMIN_SECRET=$(generate_random_string)/" .env

echo ".env file created with random passwords."
