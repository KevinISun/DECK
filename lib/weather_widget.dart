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
          // Colder icon
          weatherIcon = Icons.ac_unit;
        } else {
          // Default icon for other temperature ranges
          weatherIcon = Icons.wb_sunny;
        }

        // Convert description to lowercase for case-insensitive comparison
        description = description.toLowerCase();

        // Handle different weather descriptions
        if (description.contains('clear')) {
          // Clear sky icon
          weatherIcon = Icons.wb_sunny;
        } else if (description.contains('cloud') || description.contains('overcast')) {
          // Cloudy icon
          weatherIcon = Icons.cloud;
        } else if (description.contains('rain')) {
          // Rainy icon
          weatherIcon = Icons.waves;
        } // Add more cases as needed for different weather conditions
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
      child: Row(
        children: [
          // Display weather icon
          Icon(
            weatherIcon,
            size: 48.0,
            color: Colors.blue, // Customize icon color as needed
          ),
          SizedBox(width: 16.0),
          // Display weather data within a box with customized styling
          Container(
            padding: EdgeInsets.all(12.0), // Adjust padding as needed
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0), // Border properties
              borderRadius: BorderRadius.circular(8.0), // Border radius to create rounded corners
              color: boxColor, // Custom box color based on weather description
            ),
            child: Text(
              weatherData,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}