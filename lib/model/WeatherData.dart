class WeatherData {
  final String weatherDescription;
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final int pressure;
  final int humidity;
  final int sunrise;
  final String icon;
  final int visibility;
  final int sunset;
  final int feelsLike;

  WeatherData(
      {required this.weatherDescription,
        required this.temperature,
        required this.minTemperature,
        required this.maxTemperature,
        required this.pressure,
        required this.humidity,
        required this.sunrise,
        required this.icon,
        required this.visibility,
        required this.sunset,
        required this.feelsLike});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        weatherDescription: json['weather'][0]['description'],
        temperature: json['main']['temp'].toInt(),
        minTemperature: json['main']['temp_min'].toInt(),
        maxTemperature: json['main']['temp_max'].toInt(),
        pressure: json['main']['pressure'],
        humidity: json['main']['humidity'],
        sunrise: json['sys']['sunrise'],
        icon: json['weather'][0]['icon'],
        visibility: json['visibility'],
        sunset: json['sys']['sunset'],
        feelsLike: json['main']['feels_like'].toInt());
  }
}
