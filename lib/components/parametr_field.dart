import 'package:flutter/material.dart';

class ParametrField extends StatelessWidget {
  final String parametrName;
  final String parametrValue;
  const ParametrField({Key? key, required this.parametrName, required this.parametrValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: const EdgeInsets.all(16.0),
      height: 140,
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            parametrName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Expanded(
            child: Center(
              child: FittedBox(
                child: Text(
                  parametrValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
