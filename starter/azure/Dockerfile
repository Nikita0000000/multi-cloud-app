# Use an official HashiCorp Terraform image as a base
FROM hashicorp/terraform:1.0.5

# Set the working directory
WORKDIR /app

# Set environment variables for the Azure provider
# These should be your actual credentials; this is just an example
ENV ARM_SUBSCRIPTION_ID="94ec3a64-dcfe-4219-9e29-88221690c382"
ENV ARM_CLIENT_ID="e26a1b53-7e3c-4461-9ead-edb6c2119f78"
ENV ARM_CLIENT_SECRET="kE38Q~KKt5eHH_24h9ZNvPjxvvZZlrvXJgSNrb6k"
ENV ARM_TENANT_ID="9b7cbd77-6d6b-4879-8aba-63d7dfb18472"

# Copy your Terraform files into the container
COPY . .

# Initialize Terraform (this downloads the necessary provider plugins and sets up the backend)
RUN terraform init

# Apply Terraform configuration and keep the container running
CMD ["sh", "-c", "terraform apply -auto-approve; sleep infinity"]
