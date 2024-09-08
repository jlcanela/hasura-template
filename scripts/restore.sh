#!/bin/bash

# Set variables
PROJECT_ROOT=$(pwd)
SCRIPTS_DIR="$PROJECT_ROOT/scripts"
BACKUP_DIR="$PROJECT_ROOT/backups"

# Read environment variables
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(grep -v '^#' "$PROJECT_ROOT/.env" | xargs)
else
    echo ".env file not found in project root. Please run init.sh first."
    exit 1
fi

# Function to get the latest file with a specific prefix
get_latest_file() {
    local prefix=$1
    ls -t "$BACKUP_DIR"/${prefix}* 2>/dev/null | head -n1
}

# If no arguments are provided, use the latest backup files
if [ $# -eq 0 ]; then
    HASURA_BACKUP=$(get_latest_file "hasura_metadata_")
    POSTGRES_BACKUP=$(get_latest_file "postgres_schema_")
    
    # Check if latest backups were found
    if [ -z "$HASURA_BACKUP" ] || [ -z "$POSTGRES_BACKUP" ]; then
        echo "No backup files found in $BACKUP_DIR"
        exit 1
    fi
    
    HASURA_BACKUP=$(basename "$HASURA_BACKUP")
    POSTGRES_BACKUP=$(basename "$POSTGRES_BACKUP")
elif [ $# -eq 2 ]; then
    HASURA_BACKUP=$1
    POSTGRES_BACKUP=$2
else
    echo "Usage: $0 [<hasura_metadata_backup_file> <postgres_schema_backup_file>]"
    exit 1
fi

# Check if backup files exist
if [ ! -f "$BACKUP_DIR/$HASURA_BACKUP" ] || [ ! -f "$BACKUP_DIR/$POSTGRES_BACKUP" ]; then
    echo "Backup files not found in $BACKUP_DIR"
    exit 1
fi

echo "Using Hasura backup: $HASURA_BACKUP"
echo "Using Postgres backup: $POSTGRES_BACKUP"

# Restore PostgreSQL schema
echo "Restoring PostgreSQL schema..."
gunzip -c "$BACKUP_DIR/$POSTGRES_BACKUP" | docker-compose exec -T postgres psql -U postgres

# Restore Hasura metadata
echo "Restoring Hasura metadata..."
hasura metadata apply --endpoint "$HASURA_ENDPOINT" --admin-secret "$HASURA_GRAPHQL_ADMIN_SECRET"

echo "Restore completed."

echo "Hasura project restore and metadata export completed."
