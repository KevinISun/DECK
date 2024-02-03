# Gets the most recent weather api
import requests

def get_weather(CITY = "Santa Cruz", COUNTRY = "US"):

    BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
    API_KEY = open('api_key', 'r').read()
    CITY = "Santa Cruz"
    STATE_CODE = "06"
    COUNTRY = "US"
    url = BASE_URL + "appid=" + API_KEY + "&q=" + CITY + "," + COUNTRY + "&units=imperial"

    response = requests.get(url).json()

    print(response)
    return response


