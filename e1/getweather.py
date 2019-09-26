import os
import sys
import requests
import os
import sys
import requests
from pyowm import OWM

API_KEY = os.getenv('API_KEY')
CITY = os.getenv('CITY')
owm = OWM(API_key=API_KEY, version='2.5')
obs = owm.weather_at_place(CITY)
w = obs.get_weather()
x = w.get_temperature(unit='celsius')
for e in range(len(x)):
    if [x for x in x.keys()][e] == 'temp':
        temp = [x for x in x.values()][e]
print(f'source=\"openweathermap\", city=\"{CITY}\", status=\"{w.get_status()}\", humidity=\"{w.get_humidity()}%\", temperature=\"{temp}°C\", ')

