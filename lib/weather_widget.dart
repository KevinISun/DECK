import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String weatherData = '';
  IconData weatherIcon = Icons.error; // Default icon in case of error
  Color boxColor = Colors.white; // Default box color
  
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
    final CITY = "Santa Cruz";
    final COUNTRY = "US";
    final apiKey = 'bbb3c38ddd6eb052bdddee16a6ca50b1';
    final apiUrl = '$BASE_URL?appid=$apiKey&q=$CITY,$COUNTRY&units=imperial';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        final temperature = decodedData['main']['temp'];
        String description = decodedData['weather'][0]['description'];

        // Select icon based on temperature range and weather description
        if (temperature >= 30 && temperature <= 40) {
          weatherIcon = Icons.ac_unit;
        } else {
          weatherIcon = Icons.wb_sunny;
        }

        description = description.toLowerCase();

        if (description.contains('clear')) {
          weatherIcon = Icons.wb_sunny;
        } else if (description.contains('cloud') || description.contains('overcast')) {
          weatherIcon = Icons.cloud;
        } else if (description.contains('rain')) {
          weatherIcon = Icons.waves;
        }
        setState(() {
          weatherData = 'Temperature: $temperature°F\nDescription: $description';
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      // padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            weatherIcon,
            size: 48.0,
            color: Colors.blue,
          ),
          SizedBox(width: 16.0),
          Flexible(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: boxColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Align to the center horizontally
                  children: [
                    Text(
                      'Weather',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Divider(
                      color: Colors.blue,
                      thickness: 1.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '$weatherData',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
