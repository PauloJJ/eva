import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/utils/upload_images_util.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthAppService extends GetxController {
  RxBool isLoadingLogin = false.obs;
  RxBool isLoadingRegister = false.obs;
  RxBool isLoadingResetPassword = false.obs;

  Rx<XFile?> image = Rx(null);

  final formKeyRegister = GlobalKey<FormState>();
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyResetPassword = GlobalKey<FormState>();

  RxBool viewPassword = true.obs;

  RxString selectedCountry = '+55'.obs;

  toggleViewPassword() {
    viewPassword.value = !viewPassword.value;
  }

  registerUser({required UserModel userModel, required String password}) async {
    if (!formKeyRegister.currentState!.validate()) {
      FeedbackComponent.definitiveError(
        message: 'Verifique o campo com erro e tente novamente',
      );

      return;
    }

    if (image.value == null) {
      return FeedbackComponent.definitiveError(
        message: 'Selecione uma imagem para continuar',
      );
    }

    try {
      isLoadingRegister.value = true;

      String? imageUrl = await uploadImage(
        folderName: 'imagesPersonalNetwork',
        fileImage: File(image.value!.path),
      );

      if (imageUrl == null) {
        FeedbackComponent.definitiveError(
          message: 'Algo deu errado, Tente novamente.',
        );

        return;
      }

      userModel.profileImage = imageUrl;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(userModel.toJson());

      Get.back();
      viewPassword.value = true;
      image.value = null;
    } on FirebaseException catch (error) {
      String errorMessage = 'Algo deu errado, Tente novamente mais tarde.';

      switch (error.code) {
        case 'email-already-in-use':
          errorMessage = 'Já existe uma conta cadastrada com este e-mail.';
          break;

        case 'invalid-email':
          errorMessage = 'E-mail inválido.';
      }

      FeedbackComponent.definitiveError(message: errorMessage);
      return;
    } finally {
      isLoadingRegister.value = false;
    }
  }

  login({required String email, required String password}) async {
    if (!formKeyLogin.currentState!.validate()) {
      FeedbackComponent.definitiveError(
        message: 'Verifique o campo com erro e tente novamente',
      );

      return;
    }

    try {
      isLoadingLogin.value = true;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      viewPassword.value = true;
    } on FirebaseException catch (error) {
      String errorMessage = 'Algo deu errado, Tente novamente.';

      switch (error.code) {
        case 'invalid-email' || 'INVALID_LOGIN_CREDENTIALS':
          errorMessage = 'E-mail ou senha inválidos.';
          break;

        case 'too-many-requests':
          errorMessage =
              'Você fez muitas solicitações. Aguarde um momento e tente novamente.';
          break;
      }

      FeedbackComponent.definitiveError(
        message: errorMessage,
      );
    } finally {
      isLoadingLogin.value = false;
    }
  }

  resetPassword({required String email}) async {
    if (!formKeyResetPassword.currentState!.validate()) {
      return;
    }

    try {
      isLoadingResetPassword.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Get.back();

      FeedbackComponent.successfulAction(
        message: 'E-mail enviado. Verifique sua caixa de entrada.',
        durationSeconds: 4,
      );
    } on FirebaseAuthException {
      FeedbackComponent.definitiveError(
        message:
            'Algo deu errado. Sentimos muito — tente novamente mais tarde.',
      );

      return;
    } finally {
      isLoadingResetPassword.value = false;
    }
  }

  logout() {
    FirebaseAuth.instance.signOut();
    Get.delete<FilesService>();
  }
}
