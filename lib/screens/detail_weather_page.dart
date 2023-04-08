import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/parametr_field.dart';
import 'package:weather_app/model/WeatherApiClient.dart';
import 'package:weather_app/model/WeatherData.dart';
import 'package:intl/intl.dart';


class DetailPage extends StatelessWidget {
  final String city;
  const DetailPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cityWeather = Weather(city: city);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(city),
        ),
        body: FutureBuilder<WeatherData>(
          future: cityWeather.fetchWeather(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return  const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }
            else{
              final cityWeatherData = snapshot.data!;
              if (cityWeatherData.icon == null) {
                return const Center(child: Text('No icon available'));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage(
                            "https://openweathermap.org/img/wn/${cityWeatherData.icon}.png",
                          ),
                        ),
                        Text(
                          '${cityWeatherData.temperature.toString()}°',
                          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ParametrField(parametrName: "Feels like", parametrValue: "${cityWeatherData.feelsLike}°"),
                            ParametrField(parametrName: "Visibility", parametrValue: "${(cityWeatherData.visibility/1000).toInt()} km")
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ParametrField(parametrName: "Humidity", parametrValue: "${cityWeatherData.humidity} %"),
                            ParametrField(parametrName: "Pressure", parametrValue: "${cityWeatherData.pressure} hPa")
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ParametrField(parametrName: "Sunrise", parametrValue: "${DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(cityWeatherData.sunrise))}"),
                            ParametrField(parametrName: "Sunset", parametrValue: "${DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(cityWeatherData.sunset))}")
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
