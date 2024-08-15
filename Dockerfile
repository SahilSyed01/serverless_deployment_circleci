# Use an official image as a base
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-client \
    curl \
    wget \
    golang-go

# Set the working directory
WORKDIR /app

# Copy your deployment script into the image
COPY deploy.sh /app/deploy.sh
RUN chmod +x /app/deploy.sh

# Entry point for the image
CMD ["/app/deploy.sh"]
