import 'package:eva/ux/components/buttons_component.dart';
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

  static errorPleaseTryAgain({
    required String message,
    required Function() function,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        title: 'Algo deu errado',
        message: message,
        icon: Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red,
        mainButton: CloseButton(
          color: Colors.white,
          onPressed: () {
            function();
          },
        ),
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

  static confirmationAction({
    required String content,
    required Function() function,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Tem certeza ?'),
          content: Text(content),
          actions: [
            ButtonsComponent.buttonTextButon(
              title: 'Voltar',
              function: () {
                Get.back();
              },
            ),

            ButtonsComponent.buttonTextButon(
              title: 'Continuar',
              function: () {
                function();
              },
            ),
          ],
        );
      },
    );
  }

  static alertConfirmation({
    required String content,
    required Function() function,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(content),
          actions: [
            ButtonsComponent.buttonTextButon(
              title: 'Voltar',
              function: () {
                Get.back();
              },
            ),

            ButtonsComponent.buttonTextButon(
              title: 'Continuar',
              function: () {
                function();
              },
            ),
          ],
        );
      },
    );
  }

  static showInformation(String information) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          content: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(information),
          ),
          actions: [
            ButtonsComponent.buttonFilled(
              title: 'Voltar',
              function: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  static showErrorDefinitive({
    required String content,
  }) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Error'),
          content: Text(content),
          actions: [
            ButtonsComponent.buttonFilled(
              title: 'Voltar',
              color: Colors.red,
              function: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
