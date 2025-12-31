import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class Loading01Widget extends StatelessWidget {
  const Loading01Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_transparente.png',
              height: 290,
            ),

            SizedBox(
              height: 60,
            ),

            CircularProgressIndicator.adaptive(),
            SizedBox(height: 15),
            Text(
              'Carregando...',
              style: textStyle.titleMedium,
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
