import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String weatherData = '';

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
        final description = decodedData['weather'][0]['description'];
        setState(() {
          weatherData = 'Temperature: $temperature\nDescription: $description';
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
      padding: EdgeInsets.all(16.0),
      child: Text(
        weatherData,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
