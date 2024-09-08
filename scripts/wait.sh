#!/bin/bash

CONTAINER_NAME="rad-graphql-engine-1"

echo "Waiting for $CONTAINER_NAME to be healthy..."

while true; do
    STATUS=$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_NAME 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo "Container $CONTAINER_NAME does not exist. Waiting..."
        sleep 5
        continue
    fi

    if [ "$STATUS" = "healthy" ]; then
        echo "$CONTAINER_NAME is now healthy!"
        break
    elif [ "$STATUS" = "unhealthy" ]; then
        echo "Error: $CONTAINER_NAME is unhealthy. Please check the logs."
        exit 1
    else
        echo "Current status: $STATUS. Waiting..."
        sleep 5
    fi
done

echo "$CONTAINER_NAME is ready!"
