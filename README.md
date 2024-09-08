# Hasura GraphQL Engine with PostgreSQL

This project sets up a Hasura GraphQL Engine with a PostgreSQL database using Docker Compose. It includes a secure method for managing environment variables and generating random passwords.

## Prerequisites

- Docker
- Docker Compose
- Bash shell (for running the ./scripts/init.sh script)
- [Hasura Cli](https://hasura.io/docs/2.0/hasura-cli/install-hasura-cli/) 

## Setup Instructions

1. Clone this repository:
   ```
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Install the backend
   ```
   ./install.sh
   ```
   This script will create a .env file with random, secure passwords for sensitive fields initialize the default postgres connection and apply migrations.

3. Access the Hasura console:
   Open a web browser and navigate to `http://localhost:8080`. You'll need to use the HASURA_GRAPHQL_ADMIN_SECRET generated in the .env file to access the console.


## Reset Instructions

To clean and reset the database

1. Wipe the database
   ```
   ./reset.sh
   ```
   This script will shutdown the docker compose and delete the postgres docker volume and then restart and apply migrations. 
   

## File Structure

The configuration:
- `docker-compose.yml`: Defines the services (PostgreSQL and Hasura GraphQL Engine).
- `scripts/.env-template`: Template file for environment variables.
- `scripts/.default_metadata.json`: Default metadata configuration for Hasura, including the default PostgreSQL connection.

The setup scripts
- `./install.sh`: Main installation script that orchestrates the entire setup process.
- `scripts/apply_migrations.sh`: Applies database migrations to set up the schema.
- `scripts/configure.sh`: Generates the .env file with secure random passwords.
- `scripts/setup_db.sh`: Initializes the database connection in Hasura using the default metadata.
- `scripts/start.sh`: Starts the Docker containers for PostgreSQL and Hasura.
- `scripts/wait.sh`: Waits for the Hasura container to be healthy before proceeding.

The developer scripts
- `./reset.sh`: Resets the entire setup by wiping the database and reapplying migrations.
- `scripts/backup.sh`: Creates a backup of the current database schema and Hasura metadata.
- `scripts/restore.sh`: Restores the database and Hasura configuration from a backup.
- `scripts/wipe.sh`: Removes all data from the PostgreSQL database.

## Environment Variables

- `POSTGRES_PASSWORD`: Password for the PostgreSQL database.
- `HASURA_GRAPHQL_ENABLE_CONSOLE`: Enables the Hasura console.
- `HASURA_GRAPHQL_DEV_MODE`: Enables development mode for Hasura.
- `HASURA_GRAPHQL_ADMIN_SECRET`: Admin secret for accessing the Hasura console and API.
- `HASURA_ENDPOINT`: The URL where the Hasura GraphQL engine is accessible, typically "http://localhost:8080".

## Security Notes

- The .env file contains sensitive information and should never be committed to version control.
- Always use the provided script to generate a new .env file for new environments or team members.
- Regularly update passwords by re-running the create-env.sh script and restarting the services.

## Customization

You can modify the .env-template file to add or remove environment variables as needed for your project. Remember to update the ./scripts/configure.sh script accordingly if you add new sensitive fields that require random generation.

## Troubleshooting

If you encounter any issues:
1. Ensure Docker and Docker Compose are correctly installed and running.
2. Check that the .env file was generated correctly.
3. Verify that the ports specified in docker-compose.yml are not already in use on your system.

For more detailed information, refer to the [Hasura documentation](https://hasura.io/docs/latest/graphql/core/index.html).
