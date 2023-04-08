import 'package:flutter/material.dart';

class ErrorWeatherItem extends StatelessWidget {
  final String error;
  const ErrorWeatherItem({Key? key,required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).colorScheme.background),
        child: Center(
          child: Text(error),
        ),
      ),
    );
  }
}
