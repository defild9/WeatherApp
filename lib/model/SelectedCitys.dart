import 'package:flutter/material.dart';

class SelectedCitys extends ChangeNotifier{
  final List<String> _citys = [];

  List<String> get citys => _citys;

  void addCity(String city){
    _citys.add(city);
    notifyListeners();
  }
  void removeCity(String city){
    _citys.remove(city);
    notifyListeners();
  }
}