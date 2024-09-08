#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)
SCRIPTS_DIR="$PROJECT_ROOT/scripts"
BACKUP_DIR="$PROJECT_ROOT/backups"
DATE=$(date +"%Y%m%d_%H%M%S")

# Read environment variables
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env" | xargs)
else
    echo ".env file not found in project root. Please run init.sh first."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup Hasura metadata
echo "Backing up Hasura metadata..."
hasura metadata export --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET" #--output json > "$BACKUP_DIR/hasura_metadata_$DATE.json"

# Backup PostgreSQL schema
echo "Backing up PostgreSQL schema..."
docker-compose exec -T postgres pg_dump -U postgres --schema-only \
    --exclude-schema=hdb_catalog \
    --exclude-schema=information_schema \
    --exclude-schema=pg_catalog \
    | gzip > "$BACKUP_DIR/postgres_schema_$DATE.sql.gz"

echo "Backup completed. Files saved in $BACKUP_DIR"