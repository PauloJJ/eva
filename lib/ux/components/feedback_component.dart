import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackComponent {
  static definitiveError({required String message, int? durationSeconds}) {
    Get.showSnackbar(
      GetSnackBar(
        duration: Duration(seconds: durationSeconds ?? 3),
        title: 'Algo deu errado',
        message: message,
        icon: Icon(Icons.error, color: Colors.white),
        mainButton: CloseButton(
          color: Colors.white,
          onPressed: () {
            Get.closeAllSnackbars();
          },
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static successfulAction({required String message, int? durationSeconds}) {
    Get.snackbar(
      '',
      '',
      duration: Duration(seconds: durationSeconds ?? 3),
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      titleText: Text(
        'Ação realizada com sucesso',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      icon: Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 35,
      ),
      mainButton: TextButton(
        onPressed: () {
          Get.closeAllSnackbars();
        },
        child: Text(
          'Fechar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
