#!/bin/bash

# Stop the running containers
docker-compose down

# Remove the volume
docker volume rm $(docker volume ls -q | grep db_data)

# Optionally, you can remove all unused volumes
# docker volume prune -f

# Restart the containers
docker-compose up -d

echo "PostgreSQL filesystem has been wiped and containers restarted."
