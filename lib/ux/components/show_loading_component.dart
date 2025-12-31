import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

showLoadingComponent() async {
  Get.closeAllSnackbars();

  return showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    ),
  );
}
