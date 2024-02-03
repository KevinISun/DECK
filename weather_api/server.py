from flask import FLASK, request, jsonify
from weather import get_weather

app = FLASK(__name__)

@app.route('/send_weather_data', methods=['POST'])
def send_weather_data():
    city = request.form.get('city')
    print(city)

    weather_data = get_weather()
    return jsonify(weather_data)
    


if __name__ == '__main__':
    app.run(debug=True)