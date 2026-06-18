import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class CardInitWidget extends StatelessWidget {
  final String number;
  final String title;
  const CardInitWidget({
    super.key,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0,
      color: color.secondary,
      child: ListTile(
        leading: Text(
          number,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: color.primary,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: color.primary,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
