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

## Unit Tests

- Updated the account factory to include a cashback trait.
- Modified the account model spec to test the new cashback scope and validations.
- Created the payments request spec to include cashback-related scenarios.
These updates provide comprehensive test coverage for the new cashback functionality, ensuring that the feature works as expected and maintains the integrity of our application.

# Feature Expansions and Improvements

## Use Transaction

By wrapping the payment creation process in a transaction, we ensure data integrity.

## Code organization and maintainability

 By introducing the PaymentService, we've separated concerns and made the codebase more modular.

 ## Data integrity

 Adding validations to the Payment model helps ensure that our data remains consistent and valid.

 ## Add Cash back Index

This index will be particularly useful in scenarios like:

- When listing all cashback accounts for a user
- When checking if a user has a cashback account
- When filtering accounts to show only cashback or non-cashback accounts

It's a small change, but it can have a noticeable impact on performance, especially as the number of accounts in the system grows.

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

# Added Features

## Transaction History

I have implemented a new Transaction History feature that allows users to view a detailed log of all activities on their accounts. This feature enhances transparency and aids in financial tracking and reconciliation.

### Key Components:

1. **Transaction Model**: A new `Transaction` model has been added to store individual transaction records. Each transaction is associated with an account and includes details such as amount, transaction type (credit/debit), and description.

2. **Account Model Update**: The `Account` model has been updated to include a `has_many :transactions` association.

3. **Transactions Controller**: A new `TransactionsController` has been implemented to handle the display of transaction history for each account.

4. **Payments Controller Update**: The `PaymentsController` has been modified to automatically create transaction records when a payment is made.

5. **Transaction History View**: A new view has been added to display the transaction history in a tabular format, showing date, type, amount, and description for each transaction.

6. **Routing**: New routes have been added to support the transaction history feature.

### Feature Behavior:

- When a payment is made, two transaction records are automatically created:
  - A 'debit' transaction for the source account
  - A 'credit' transaction for the destination account
- Users can view the transaction history for each of their accounts
- Transactions are displayed in reverse chronological order (newest first)

### Benefits:

1. **Improved Transparency**: Users can now see a complete history of all transactions for each account.
2. **Better Financial Tracking**: The detailed transaction log helps users keep track of their financial activities more effectively.
3. **Easier Reconciliation**: With a comprehensive transaction history, it's easier for users to reconcile their accounts and spot any discrepancies.

This new feature significantly enhances the functionality of our banking application, providing users with more detailed insights into their account activities.

## Unit Tests

- The transaction factory is created to ease the data preparation in specs.
- The account factory has been updated to support the new Transaction History feature.
- A new :with_transactions trait has been added to the account factory, allowing for easy creation of accounts with associated transactions in tests.

## Email Notifications (From our Interview :) 

I have implemented an email notification system to keep users informed about their account activities. This feature enhances user experience and provides important updates in real-time.

### Key Components:

1. **Email Service**: A new `EmailService` class has been added to handle various types of email notifications.
2. **Mailer Class**: A `UserMailer` class has been implemented to define different email templates and logic.
3. **Email Templates**: HTML templates for different types of emails (payment confirmation, low balance alert, cashback notification) have been created.

### Email Types:

- **Payment Confirmation**: Sent after a successful payment transaction.
- **Low Balance Alert**: Triggered when an account balance falls below a certain threshold.
- **Cashback Notification**: Sent when a user earns cashback from a transaction.

### Technical Implementation:

- **Development Environment**: I used the `letter_opener` gem for testing emails. This gem opens emails in the browser instead of actually sending them, making it easy to preview and debug email content.

- **Production Environment**: For production, I'd have configured the application to use SMTP for sending emails. This ensures reliable delivery of transactional emails in the live environment.

### Benefits:

1. **Improved Communication**: Users receive timely updates about their account activities.
2. **Enhanced Security**: Email notifications for important account actions help users stay informed about their account status.
3. **Better User Engagement**: Regular notifications keep users engaged with the application.

This email notification system significantly enhances the functionality of our banking application, providing users with more detailed and timely information about their account activities.