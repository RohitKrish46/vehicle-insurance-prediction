# Vehicle-Insurance-Prediction

[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-blue.svg)](https://www.python.org/)
![uv](https://img.shields.io/badge/uv-0.6.12-purple)
![FastAPI](https://img.shields.io/badge/FastAPI-0.115.12-green)
[![Docker](https://img.shields.io/badge/Docker-28.2.2-blue?logo=docker)](https://hub.docker.com/r/yourusername/your-repo)
[![MongoDB](https://img.shields.io/badge/MongoDB-8.0-darkgreen?logo=mongodb&logoColor=white)](https://www.mongodb.com/)


[![CI](https://img.shields.io/badge/CI-Passing-brightgreen)](https://github.com/RohitKrish46/vehicle-insurance-prediction/actions)
![Runner](https://img.shields.io/badge/Runner-Self--Hosted%20EC2-orange)
[![S3 Upload](https://img.shields.io/badge/AWS_S3-Artifact%20store-success)](https://aws.amazon.com/s3)
[![AWS EC2](https://img.shields.io/badge/AWS_EC2-Deployed-yellow?logo=amazon-ec2)](https://aws.amazon.com/ec2)
![Docker](https://img.shields.io/badge/AWS_ECR-%20Pushed-red)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repo implements an end-to-end Machine Learning pipeline for vehicle Insurance prediction, covering data ingestion, validation, transformation, model training, evaluation, and deployment using AWS services and CI/CD with GitHub Actions.

## Table of Contents

1.  [Project Overview](#project-overview)
2.  [Features](#features)
3.  [Local Setup](#local-setup)
4.  [MongoDB Atlas Setup](#mongodb-atlas-setup)
5.  [AWS Setup](#aws-setup)
6.  [Project Structure](#project-structure)
7.  [CI/CD Pipeline](#cicd-pipeline)
8.  [Deployment](#deployment)
9.  [Usage](#usage)
## Project Overview

This project provides a robust framework for building and deploying machine learning models. It demonstrates best practices for MLOps, including:

* **Modular Codebase:** Organized into logical components for maintainability.
* **Data Handling:** Secure connection to MongoDB Atlas for data storage and retrieval.
* **Pipeline Orchestration:** Automated stages for data ingestion, validation, transformation, and model training.
* **Model Management:** Versioning and storage of models on AWS S3.
* **Deployment:** Containerization with Docker and deployment on AWS EC2.
* **CI/CD:** Automated build, push to ECR, and deployment to EC2 using GitHub Actions.

## Features

* **Data Ingestion:** Fetches vehicle data from MongoDB Atlas.
* **Data Validation:** Ensures data quality and schema compliance.
* **Data Transformation:** Preprocesses raw data for model training.
* **Model Training:** Trains a machine learning model on the processed data.
* **Model Evaluation:** Assesses model performance and handles model versioning (if performance improves).
* **Model Pusher:** Uploads the best performing model to an AWS S3 bucket.
* **Prediction Pipeline:** Provides an API endpoint for real-time predictions.
* **Scalable Architecture:** Designed for cloud deployment with AWS.
* **Automated CI/CD:** Streamlined development-to-deployment workflow.
* **Logging & Exception Handling:** Robust error management and tracking.

## Local Setup

Follow these steps to set up the project locally:

1.  **Clone the Repository:**
    ```bash
    git clone <your-repo-url>
    cd <your-project-directory>
    ```

2.  **Create Project Template:**
    If starting from scratch, execute the template creation script:
    ```bash
    python template.py
    ```

3.  **Configure Local Package Imports:**
    Ensure `setup.py` and `pyproject.toml` are correctly configured to allow importing local packages. Refer to `crashcourse.txt` for details on this setup.

4.  **Create and Activate Virtual Environment:**
    It's highly recommended to use a virtual environment to manage dependencies.
    ```bash
    conda create -n vehicle python=3.10 -y
    conda activate vehicle
    ```

5.  **Install Dependencies:**
    Make sure all required modules are listed in `requirements.txt`.
    ```bash
    pip install -r requirements.txt
    ```

6.  **Verify Local Packages:**
    Run `pip list` to confirm that all necessary packages, including your local project modules, are installed.

## MongoDB Atlas Setup

This project uses MongoDB Atlas for data storage.

1.  **Sign Up for MongoDB Atlas:**
    Go to [MongoDB Atlas](https://cloud.mongodb.com/) and sign up.

2.  **Create a New Project:**
    Follow the prompts to create a new project, providing a name and accepting defaults.

3.  **Create a Cluster:**
    * From the "Create a Cluster" screen, click "Create".
    * Select the `M0` (Free Tier) service, keeping other settings as default.
    * Click "Create Deployment".

4.  **Setup Database User:**
    * Create a new database user with a secure username and password. Save these credentials.

5.  **Configure Network Access:**
    * Go to "Network Access" and add an IP Address. For development, you can add `0.0.0.0/0` to allow access from anywhere (be cautious with this in production for security reasons).

6.  **Get Connection String:**
    * Go back to your project overview.
    * Click "Connect" for your cluster.
    * Select "Connect your application".
    * Choose `Python` as the Driver and `3.6 or later` as the Version.
    * Copy the connection string. **Remember to replace `<password>` with your actual database user password.** Save this connection string securely.

7.  **Push Data to MongoDB:**
    * Create a `notebook` folder in your project root.
    * Place your dataset file (e.g., CSV, JSON) inside the `notebook` folder.
    * Create a Jupyter Notebook file `mongoDB_demo.ipynb` inside the `notebook` folder.
    * In the notebook, select the `vehicle` Python kernel.
    * Write Python code in `mongoDB_demo.ipynb` to connect to your MongoDB Atlas cluster using the connection string and push your dataset.
    * Verify data in MongoDB Atlas: Go to "Database" -> "Browse Collections" to see your data.

8.  **Set MongoDB URL as Environment Variable:**
    Your application will read the MongoDB connection string from an environment variable named `MONGODB_URL`.

    * **For Bash (Linux/macOS):**
        ```bash
        export MONGODB_URL="mongodb+srv://<username>:<password>@cluster0.abcde.mongodb.net/?retryWrites=true&w=majority"
        # Verify:
        echo $MONGODB_URL
        ```
    * **For PowerShell (Windows):
        ```powershell
        $env:MONGODB_URL = "mongodb+srv://<username>:<password>@cluster0.abcde.mongodb.net/?retryWrites=true&w=majority"
        # Verify:
        echo $env:MONGODB_URL
        ```
    * **For Permanent Windows Environment Variable:**
        Go to Environment Variables settings, add a new system variable:
        * Name: `MONGODB_URL`
        * Value: `your_mongodb_connection_string`

## AWS Setup

This project uses AWS S3 for model storage and AWS EC2 for deployment.

1.  **Login to AWS Console:**
    Go to [AWS Console](https://aws.amazon.com/console/) and log in. Keep your region set to `us-east-1` (N. Virginia) for consistency.

2.  **Create IAM User for Application Access:**
    * Go to `IAM` -> `Users` -> `Create user`.
    * Name the user (e.g., `firstproj`).
    * Attach policies directly: Select `AdministratorAccess` (for simplicity in development; use more granular permissions in production).
    * Complete user creation.
    * Click on the newly created user -> `Security Credentials` -> `Create access key`.
    * Select `Command Line Interface (CLI)` -> Acknowledge the condition -> `Next` -> `Create Access Key`.
    * **Download the `.csv` file** containing `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. **Keep these credentials secure.**

3.  **Set AWS Credentials as Environment Variables:**
    Your application will use these credentials to interact with AWS services.

    * **For Bash (Linux/macOS):**
        ```bash
        export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
        export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
        export AWS_DEFAULT_REGION="us-east-1" # Or your chosen region
        # Verify:
        echo $AWS_ACCESS_KEY_ID
        echo $AWS_SECRET_ACCESS_KEY
        echo $AWS_DEFAULT_REGION
        ```
    * **For PowerShell (Windows):**
        ```powershell
        $env:AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
        $env:AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
        $env:AWS_DEFAULT_REGION="us-east-1" # Or your chosen region
        # Verify:
        echo $env:AWS_ACCESS_KEY_ID
        echo $env:AWS_SECRET_ACCESS_KEY
        echo $env:AWS_DEFAULT_REGION
        ```
    * Also, update your `src/constants/__init__.py` with these values or ensure they are read from environment variables.

4.  **Create S3 Bucket for Models:**
    * Go to `S3` service -> `Create bucket`.
    * Region: `us-east-1`.
    * Bucket Name: `my-model-mlopsproj` (or your chosen unique name).
    * **Uncheck `Block all public access` and acknowledge the warning** (as the application needs to access it).
    * Hit `Create Bucket`.

## Project Structure

The project follows a modular structure with dedicated directories for different functionalities:

* `artifacts/`: Stores pipeline artifacts (e.g., processed data, trained models). This directory should be added to `.gitignore`.
* `config/`: Configuration files (e.g., `schema.yaml` for data validation, `aws_connection.py`).
* `constants/`: Global constants and configurations (`__init__.py`).
* `entity/`: Defines data structures (config entities, artifact entities, S3 estimator).
    * `s3_estimator.py`: Functions to pull/push models from/to S3.
* `components/`: Individual pipeline components (data ingestion, data validation, data transformation, model trainer, model evaluation, model pusher).
* `data_access/`: Handles interaction with data sources (e.g., `VB_data.py` for MongoDB).
* `notebook/`: Jupyter notebooks for EDA, feature engineering, and data pushing to MongoDB.
* `pipline/`: Orchestrates the machine learning pipeline (e.g., `training_pipeline.py`, `prediction_pipeline.py`).
* `src/cloud_storage/`: Code for AWS S3 interactions.
* `utils/`: Utility functions (e.g., `main_utils.py` for schema validation).
* `app.py`: The main Flask application entry point for the prediction pipeline.
* `demo.py`: A script for testing individual components and the training pipeline.
* `requirements.txt`: Python package dependencies.
* `setup.py`: For packaging local modules.
* `pyproject.toml`: For project metadata and build system.
* `Dockerfile`: For containerizing the application.
* `.dockerignore`: Specifies files/directories to exclude from Docker build context.
* `.github/workflows/aws.yaml`: GitHub Actions workflow for CI/CD.
* `static/`: Static web assets (CSS, JS).
* `template/`: HTML templates for the web UI.

## CI/CD Pipeline

The project utilizes GitHub Actions for Continuous Integration and Continuous Deployment.

1.  **EC2 Instance Setup for Self-Hosted Runner:**
    * **Launch EC2 Instance:**
        * Go to `EC2` -> `Launch Instance`.
        * Name: `vehicledata-machine`.
        * AMI: `Ubuntu Server 24.04 LTS` (Free tier eligible).
        * Instance Type: `t2.medium` (Note: This might incur charges, approx. 3.5 Rs/hr).
        * Key Pair: `Create new key pair` (e.g., `proj1key`) and download it.
        * Network settings: Allow HTTPS and HTTP traffic.
        * Storage: 30GB.
        * Launch instance.
    * **Connect to EC2:**
        * Go to your instance, click "Connect".
        * Select "EC2 Instance Connect" -> "Connect". A terminal will launch.
    * **Install Docker on EC2:**
        ```bash
        sudo apt-get update -y
        sudo apt-get upgrade -y
        curl -fsSL [https://get.docker.com](https://get.docker.com) -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker ubuntu # Add ubuntu user to docker group
        newgrp docker # Apply group changes immediately
        # Verify: docker --version
        ```

2.  **Configure GitHub Self-Hosted Runner:**
    * On your GitHub project: `Settings` -> `Actions` -> `Runners` -> `New self-hosted runner`.
    * Select `Linux` as the OS.
    * Follow the "Download" commands step-by-step on your EC2 instance's terminal.
    * Run the **first "Configure" command:**
        ```bash
        ./config.sh --url [https://github.com/](https://github.com/)<your-username>/<your-repo-name> --token <your-token>
        ```
        * Press Enter for "runner group" (default).
        * Enter `self-hosted` for "runner name".
        * Press Enter for "additional labels".
        * Press Enter for "name of work folder".
    * Run the **second "Configure" command:**
        ```bash
        ./run.sh
        ```
        The runner will connect to GitHub. Verify its status as "idle" under GitHub `Settings` -> `Actions` -> `Runners`. If you disconnect (`Ctrl+C`), restart with `./run.sh`.

3.  **Create AWS IAM User for CI/CD:**
    * Create another IAM user in AWS console, exactly like step 5.2. This user will be used by GitHub Actions for AWS operations.
    * Download its `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

4.  **Create AWS ECR Repository:**
    * Go to `ECR` service -> `Create repository`.
    * Region: `us-east-1`.
    * Repository Name: `vehicleproj` (or your chosen name).
    * Hit `Create repository`. **Copy and save its URI.**

5.  **Configure GitHub Secrets:**
    * On your GitHub project: `Settings` -> `Secrets and variables` -> `Actions` -> `New repository secret`.
    * Add the following secrets:
        * `AWS_ACCESS_KEY_ID` (from the CI/CD IAM user)
        * `AWS_SECRET_ACCESS_KEY` (from the CI/CD IAM user)
        * `AWS_DEFAULT_REGION` (e.g., `us-east-1`)
        * `ECR_REPO` (the URI of your ECR repository, e.g., `123456789012.dkr.ecr.us-east-1.amazonaws.com/vehicleproj`)

6.  **CI/CD Trigger:**
    * The CI/CD pipeline (`.github/workflows/aws.yaml`) will automatically trigger on your next `git commit` and `git push`. It will build the Docker image, push it to ECR, and deploy it to your EC2 instance.

## Deployment

After the CI/CD pipeline successfully deploys your Docker image to EC2:

1.  **Open EC2 Port 5080:**
    The application will run on port 5000 inside the container, mapped to host port 5080. You need to open this port in your EC2 instance's security group.
    * Go to your EC2 instance -> `Security` tab -> Click on the `Security Groups` link.
    * `Edit inbound rules` -> `Add rule`.
    * Type: `Custom TCP`
    * Port range: `5080`
    * Source: `0.0.0.0/0` (Allow from anywhere; restrict this in production for security).
    * `Save rules`.

2.  **Access the Application:**
    * Get your EC2 instance's Public IPv4 address.
    * Paste it into your web browser's address bar, followed by `:5080`:
        ```
        http://<YOUR_EC2_PUBLIC_IP>:5080
        ```
    Your application's web interface should now be accessible.

## Usage

* Access the main application via the deployed URL (`http://<YOUR_EC2_PUBLIC_IP>:5080`).
* The application also supports model training via the `/training` route (check your `app.py` for exact endpoints and methods).
