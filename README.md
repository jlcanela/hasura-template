# Hasura GraphQL Engine with PostgreSQL

This project sets up a Hasura GraphQL Engine with a PostgreSQL database using Docker Compose. It includes a secure method for managing environment variables and generating random passwords.

## Prerequisites

- Docker
- Docker Compose
- Bash shell (for running the create-env.sh script)

## Setup Instructions

1. Clone this repository:
   ```
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Generate the .env file:
   ```
   ./create-env.sh
   ```
   This script will create a .env file with random, secure passwords for sensitive fields.

3. Start the services:
   ```
   docker-compose up -d
   ```

4. Access the Hasura console:
   Open a web browser and navigate to `http://localhost:8080`. You'll need to use the HASURA_GRAPHQL_ADMIN_SECRET generated in the .env file to access the console.

## File Structure

- `docker-compose.yml`: Defines the services (PostgreSQL and Hasura GraphQL Engine).
- `.env-template`: Template file for environment variables.
- `create-env.sh`: Script to generate a .env file with random passwords.
- `.env`: (Generated) Contains actual environment variables and passwords.

## Environment Variables

- `POSTGRES_PASSWORD`: Password for the PostgreSQL database.
- `HASURA_GRAPHQL_ENABLE_CONSOLE`: Enables the Hasura console.
- `HASURA_GRAPHQL_DEV_MODE`: Enables development mode for Hasura.
- `HASURA_GRAPHQL_ADMIN_SECRET`: Admin secret for accessing the Hasura console and API.

## Security Notes

- The .env file contains sensitive information and should never be committed to version control.
- Always use the provided script to generate a new .env file for new environments or team members.
- Regularly update passwords by re-running the create-env.sh script and restarting the services.

## Customization

You can modify the .env-template file to add or remove environment variables as needed for your project. Remember to update the create-env.sh script accordingly if you add new sensitive fields that require random generation.

## Troubleshooting

If you encounter any issues:
1. Ensure Docker and Docker Compose are correctly installed and running.
2. Check that the .env file was generated correctly.
3. Verify that the ports specified in docker-compose.yml are not already in use on your system.

For more detailed information, refer to the [Hasura documentation](https://hasura.io/docs/latest/graphql/core/index.html).
