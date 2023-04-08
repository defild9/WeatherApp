import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/error_weather_item.dart';
import 'package:weather_app/components/weather_item.dart';
import 'package:weather_app/model/SelectedCitys.dart';
import 'package:weather_app/model/ThemeManager.dart';
import 'package:weather_app/model/WeatherApiClient.dart';
import 'package:weather_app/model/WeatherData.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCitys = Provider.of<SelectedCitys>(context, listen: true);
    final themeManager = Provider.of<ThemeManager>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      theme: themeManager.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            IconButton(
              icon: Icon(
                themeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                themeManager.toggleTheme();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add city to list',
                  prefixIcon: const Icon(Icons.add),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    selectedCitys.addCity(value);
                  }
                },
              ),
            ),
            if (selectedCitys.citys.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: selectedCitys.citys.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cityWeather =
                    Weather(city: selectedCitys.citys[index]);
                    return FutureBuilder<WeatherData>(
                      future: cityWeather.fetchWeather(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final cityWeatherData = snapshot.data!;
                          return WeatherItem(
                            city: selectedCitys.citys[index],
                            description: cityWeatherData.weatherDescription,
                            temperature: cityWeatherData.temperature,
                            maxTemperature: cityWeatherData.maxTemperature,
                            minTemperature: cityWeatherData.minTemperature,
                          );
                        } else if (snapshot.hasError) {
                          return ErrorWeatherItem(
                            error: snapshot.error.toString(),
                          );
                        }
                        return const ListTile(
                          title: Text('Loading'),
                        );
                      },
                    );
                  },
                ),
              )
            else
              const Center(
                child: Text(
                    "No one city is selected for weather tracking("),
              )
          ],
        ),
      ),
    );
  }
}
