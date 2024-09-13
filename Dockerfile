# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install bundler
RUN gem install bundler

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
COPY start.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/start.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]