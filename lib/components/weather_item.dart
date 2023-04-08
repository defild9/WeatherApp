import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/SelectedCitys.dart';
import 'package:weather_app/screens/detail_weather_page.dart';


class WeatherItem extends StatelessWidget {
  final String city;
  final String description;
  final int temperature;
  final int maxTemperature;
  final int minTemperature;

  const WeatherItem(
      {Key? key,
      required this.city,
      required this.description,
      required this.temperature,
      required this.maxTemperature,
      required this.minTemperature})
      : super(key: key);

  void _showDetailWeatherInformation(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DetailPage(city: city,)));
  }

  @override
  Widget build(BuildContext context) {
    final selectedCitys = Provider.of<SelectedCitys>(context);
    return Dismissible(
      key: Key(city),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Hero(
            transitionOnUserGestures: true,
            tag: city,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => _showDetailWeatherInformation(context),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).colorScheme.background),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${city}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(
                            "${temperature}°",
                            style: const TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${description}"),
                          Text('Max:${maxTemperature}°, min:${minTemperature}°')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
      onDismissed: (direction) => selectedCitys.removeCity(city),
    );
  }
}
