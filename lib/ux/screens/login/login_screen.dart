import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'E-mail',
                style: textStyle.titleLarge,
              ),
              SizedBox(height: 10),
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
