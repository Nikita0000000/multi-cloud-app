# Use an official Python runtime as a parent image
FROM python:3.7-slim

# Set the working directory in the container to /app
WORKDIR /app

# Add metadata to an image
LABEL maintainer="nikita0598"
LABEL version="1.0"

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages directly 
RUN pip install --no-cache-dir requests numpy pandas flask django scikit-learn 

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run app.py when the container launches
CMD ["python", "app.py"]
