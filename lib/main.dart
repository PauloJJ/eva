import 'package:eva/services/inject_dependency.dart';
import 'package:eva/theme/app_theme.dart';
import 'package:eva/ux/components/auth_or_app_component.dart';
import 'package:eva/ux/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  await InjectDependency.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: AuthOrAppComponent(),
    );
  }
}
