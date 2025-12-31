import 'package:flutter/material.dart';

class Loading02Widget extends StatelessWidget {
  const Loading02Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
