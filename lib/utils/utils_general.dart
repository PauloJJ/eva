import 'package:flutter/material.dart';
import 'package:get/get.dart';

Size get size => MediaQuery.of(Get.context!).size;
TextTheme get textStyle => TextTheme.of(Get.context!);
ColorScheme get color => Theme.of(Get.context!).colorScheme;
