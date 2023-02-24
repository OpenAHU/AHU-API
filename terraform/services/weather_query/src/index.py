weather_dict ={
    "CLEAR_DAY": "☀️",
    "CLEAR_NIGHT": "🌙",
    "PARTLY_CLOUDY_DAY": "⛅️",
    "PARTLY_CLOUDY_NIGHT": "☁️",
    "CLOUDY": "☁️",
    "WIND": "🌬",
    "LIGHT_RAIN": "🌧",
    "MODERATE_RAIN": "🌧",
    "HEAVY_RAIN": "🌧",
    "STORM_RAIN": "🌧",
    "LIGHT_SNOW": "🌨",
    "MODERATE_SNOW": "🌨",
    "HEAVY_SNOW": "🌨",
    "STORM_SNOW": "🌨",
    "HAIL": "🌨",
    "SLEET": "🌨",
    "FOG": "🌫",
    "DUST": "🌫",
    "SAND": "🌫"
}

import sys
sys.path.append('./lib')
import requests


def handler(event, context):
    url = "https://api.caiyunapp.com/v2.6/TAkhjf8d1nlSlspN/117.2290,31.8206/daily?dailysteps=2"
    resp = requests.get(url).json()
    today, tomorrow = resp['result']['daily']['skycon']
    today = weather_dict[today['value']]
    tomorrow = weather_dict[tomorrow['value']]
    return {
        "isBase64Encoded": False,
        "statusCode": 200,
        "body": {
            "today": today,
            "tomorrow": tomorrow
        }
    }
