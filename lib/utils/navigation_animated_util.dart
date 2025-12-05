import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

toScreenDownToUp(Widget screen) {
  Get.to(
    () => screen,
    transition: Transition.downToUp,
  );
}
