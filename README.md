# Cash Back Feature

I've implemented a cashback feature that automatically rewards users with 5% of their transaction amount for each payment made. This feature involved several changes to the existing codebase:

### Database Changes

I added a `cashback` boolean column to the `accounts` table. This new column allows distinguishing cashback accounts from regular accounts.

### Model Updates

I updated the `Account` model to include a scope for cashback accounts. This scope provides an easy way to query for cashback accounts.

### Controller Logic

I modified the `PaymentsController` to handle the cashback logic. Key changes in the controller include:
- Wrapping the payment creation process in a transaction to ensure data integrity.
- Adding a `process_cashback` method that:
  - Calculates the cashback amount (5% of the payment amount).
  - Finds or creates a cashback account for the user.
  - Updates the cashback account balance.

### Feature Behavior

- For each payment made, 5% of the transaction amount is automatically calculated as cashback.
- If the user doesn't have a cashback account, one is automatically created.
- The cashback amount is added to the user's cashback account balance.
- All these operations are performed within a single database transaction to ensure consistency.

# Unit Tests

- Updated the account factory to include a cashback trait.
- Modified the account model spec to test the new cashback scope and validations.
- Created the payments request spec to include cashback-related scenarios.
These updates provide comprehensive test coverage for the new cashback functionality, ensuring that the feature works as expected and maintains the integrity of our application.

# Feature Expansions and Improvements

## Dockerization of the Application

We have expanded the project to include a complete Docker setup, making it easier to develop, test, and deploy the application consistently across different environments. This feature includes:

- A `Dockerfile` for building the application image
- A `docker-compose.yml` file for orchestrating the application services
- A `start.sh` script for automating database setup and application startup

### Key Benefits:

1. **Consistent Development Environment**: Ensures all developers work with the same setup, regardless of their local machine configuration.

2. **Easy Setup**: New team members can get the application running with just a few commands, without needing to install dependencies manually.

3. **Automated Database Management**: The start script automatically sets up, migrates, and seeds the development and test databases.

4. **Integrated Services**: Includes PostgreSQL and Redis services, configured and ready to use.

5. **Production-like Environment**: The dockerized setup closely mimics the production environment, reducing "it works on my machine" issues.

### Usage:

To use the dockerized setup:

1. Ensure Docker and Docker Compose are installed on your machine.
2. Clone the repository.
3. Run `docker-compose build` to build the Docker images.
4. Run `docker-compose up` to start the application.

The application will be available at `http://localhost:3000`.

This dockerization feature significantly improves the development workflow and sets the stage for easier deployment and scaling in the future.