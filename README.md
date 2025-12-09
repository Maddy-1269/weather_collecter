# Weather Data Collection System — DevOps Project

This project is a Weather Data Collection System that demonstrates core DevOps practices by combining real-time external API integration, automation, cloud storage, and infrastructure-as-code concepts.

It fetches live weather data for multiple cities, stores it in AWS S3, and maintains historical records automatically.

# Features
Feature	Description
Fetch real-time weather	Uses OpenWeather REST API
Multi-city support	Tracks London, Hyderabad, Dallas, New York
Stores data in AWS S3	Each city stored separately
Folder-based storage	Organized by city name
JSON formatted data	Timestamped for history
Environment-based config	Secure secret handling using .env
Infrastructure as Code	Terraform creates S3 resources
Git support	.gitignore + version control
Virtual environment	Dependency isolation
# Tech Stack
Technology	Purpose
Python 3	Core scripting
Terraform (IaC)	AWS infrastructure provisioning
AWS S3	Storage
OpenWeather API	Weather data provider
boto3	AWS Python SDK
python-dotenv	Environment management
requests	API calls
Git	Version Control
# Project Structure
weather-devops-project/
│

├─ src/

│  └─ weather_collector.py

│

├─ .env

├─ .gitignore

├─ requirements.txt

│

├─ terraform/

│   ├─ main.tf

│   ├─ variables.tf

│   ├─ outputs.tf

│

└─ README.md

# Setup Instructions
## Clone the Repository
git clone <repo-url>
cd weather-devops-project

# Create Virtual Environment
python3 -m venv venv
source venv/bin/activate   # Linux or Mac
venv\Scripts\activate      # Windows

# Install Required Packages
pip install -r requirements.txt


If no requirements.txt file exists:

pip install boto3 python-dotenv requests

# Configure Environment Variables

Create a .env file:

OPENWEATHER_API_KEY=YOUR_OPENWEATHER_KEY
AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
AWS_REGION=ap-south-1
S3_BUCKET_NAME=my-weather-data-bucket-pr-2025


# Do NOT commit .env to Git.

## Deploy Infrastructure (Terraform)

Go to terraform directory:

cd terraform
terraform init
terraform apply -auto-approve


This creates the S3 bucket required for storage.

## Run the Application
python3 src/weather_collector.py


Output example:

Uploaded London weather file: https://S3-URL/London/file.json
Uploaded Hyderabad weather file: https://S3-URL/Hyderabad/file.json
Uploaded Dallas weather file: https://S3-URL/Dallas/file.json
Uploaded New York weather file: https://S3-URL/New York/file.json


Each city → Unique link → Organized in folders.

## S3 Folder Output Example
my-weather-data-bucket-pr-2025
│


├─ London/

│   └─ london-weather-timestamp.json

├─ Hyderabad/

├─ Dallas/

└─ New York/

## .gitignore (Recommended)
venv/
.env
__pycache__/
terraform.tfstate
terraform.tfstate.backup
.terraform/
.terraform.lock.hcl

## Future Enhancements (Optional)
Enhancement	Benefit
Store in DynamoDB	Queryable history
Add Lambda Trigger	Auto-process incoming data
Deploy via Docker	Containerized execution
CI/CD Pipeline	Auto deploy updates
API Gateway	Provide public API


![alt text](image.png)