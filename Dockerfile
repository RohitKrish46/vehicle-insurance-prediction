FROM python:3.10-slim-buster

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . /app

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["python3", "app.py"]