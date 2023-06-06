# Use an official Node.js runtime as a parent image
FROM node:14.21.3

# Set the working directory in the container to /app
WORKDIR /app

# Install system dependencies required for Terraform
RUN apt-get update && \
    apt-get install -y unzip wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
RUN unzip terraform_1.4.6_linux_amd64.zip && mv terraform /usr/local/bin/ && rm terraform_1.4.6_linux_amd64.zip

# Copy the current directory contents into the container at /app
COPY . .

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Set environment variables for the Azure provider
# These should be your actual credentials; this is just an example
ENV ARM_SUBSCRIPTION_ID="94ec3a64-dcfe-4219-9e29-88221690c382"
ENV ARM_CLIENT_ID="e26a1b53-7e3c-4461-9ead-edb6c2119f78"
ENV ARM_CLIENT_SECRET="kE38Q~KKt5eHH_24h9ZNvPjxvvZZlrvXJgSNrb6k"
ENV ARM_TENANT_ID="9b7cbd77-6d6b-4879-8aba-63d7dfb18472"

# Install some common Node.js packages
RUN npm install express dotenv cors morgan request body-parser nodemon

# Initialize Terraform (this downloads the necessary provider plugins and sets up the backend)
RUN terraform init

# Create a placeholder script to keep the container running
RUN echo "setInterval(() => {}, 1000);" > keepalive.js

# Run the placeholder script when the container launches
CMD ["node", "keepalive.js"]
