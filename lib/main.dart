import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/SelectedCitys.dart';
import 'package:weather_app/model/ThemeManager.dart';
import 'package:weather_app/screens/main_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeManager()),
      ChangeNotifierProvider(create: (context) => SelectedCitys()),
    ],
    child: const MainPage(),
  ));
}
