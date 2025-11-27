import 'package:eva/services/hive_service.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: ButtonsComponent(
          title: 'Iniciar',
          function: () {
            HiveService().initHive();
          },
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/welcome.png',
                height: 400,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Text(
                    'Bem-vinda à Eva',
                    style: textStyle.headlineLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A Eva foi criada para apoiar mulheres que enfrentam situações de agressão, oferecendo recursos que cuidam de você quando mais precisa. 💜',
                    style: textStyle.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
