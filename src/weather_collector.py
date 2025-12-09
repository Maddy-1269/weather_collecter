import requests
import boto3
import json
import os
from datetime import datetime
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

OPENWEATHER_API_KEY = os.getenv("OPENWEATHER_API_KEY")
S3_BUCKET_NAME = os.getenv("S3_BUCKET_NAME")
AWS_REGION = os.getenv("AWS_REGION", "ap-south-1")

cities = ["London", "Hyderabad", "Dallas", "New York"]

def fetch_weather(city):
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={OPENWEATHER_API_KEY}&units=imperial"
    
    response = requests.get(url)
    
    if response.status_code != 200:
        raise Exception(f"Failed API request for {city}: {response.text}")
    
    return response.json()

def save_to_s3(city, data):
    s3_client = boto3.client("s3", region_name=AWS_REGION)

    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    file_name = f"{city.lower()}-weather-{timestamp}.json"
    key_path = f"{city}/{file_name}"  # Creates folder by city

    s3_client.put_object(
        Bucket=S3_BUCKET_NAME,
        Key=key_path,
        Body=json.dumps(data),
        ContentType='application/json'
    )

    file_url = f"https://{S3_BUCKET_NAME}.s3.amazonaws.com/{key_path}"
    print(f"✔ Uploaded {city} weather file: {file_url}")

def main():
    for city in cities:
        try:
            data = fetch_weather(city)
            city_weather = {
                "city": city,
                "temperature_F": data["main"]["temp"],
                "humidity": data["main"]["humidity"],
                "condition": data["weather"][0]["description"],
                "timestamp": datetime.now().isoformat()
            }
            save_to_s3(city, city_weather)

        except Exception as e:
            print(f"Error fetching {city}: {e}")

if __name__ == "__main__":
    main()
