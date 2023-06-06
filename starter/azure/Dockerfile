# Use an official HashiCorp Terraform image as a base
FROM hashicorp/terraform:1.0.5

# Set the working directory
WORKDIR /app

# Set environment variables for the Azure provider
# These should be your actual credentials; this is just an example
ENV ARM_CLIENT_ID="student_10f0d4vxli8q06s8_001544326@vocareumvocareum.onmicrosoft.com"
ENV ARM_CLIENT_SECRET="1lp1K$CNSHUdBJcEeSi5cgBOva2P4ny!78#RK"

# Copy your Terraform files into the container
COPY . .

# Initialize Terraform (this downloads the necessary provider plugins and sets up the backend)
RUN terraform init

CMD ["apply", "-auto-approve"]
