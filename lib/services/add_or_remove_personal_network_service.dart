import 'dart:io';
import 'dart:math';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/personal_network_model.dart';
import 'package:eva/utils/pick_image_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddOrRemovePersonalNetworkService extends GetxController {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  Rx<XFile?> imagePath = Rx(null);

  final formKey = GlobalKey<FormState>();

  RxBool isLoadingAddPersonal = false.obs;

  addPersonalNetwork() async {
    if (!formKey.currentState!.validate()) {
      FeedbackComponent.definitiveError(
        message: 'Verifique o campo com erro e tente novamente',
      );

      return;
    }

    try {
      isLoadingAddPersonal.value = true;

      final userId = FirebaseAuth.instance.currentUser!.uid;

      PersonalNetworkModel personalNetworkModel = PersonalNetworkModel(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text.isEmpty ? null : emailController.text,
        image: imagePath.value?.path,
      );

      String? imageUrl;

      if (imagePath.value != null) {
        imageUrl = await uploadImage();
      }

      personalNetworkModel.image = imageUrl;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('personalNetwork')
          .doc()
          .set(personalNetworkModel.toJson());

      Get.back();

      FeedbackComponent.successfulAction(
        message: 'Cadastro realizado com sucesso',
      );

      await Future.delayed(Durations.extralong4);
    } on FirebaseException catch (_) {
      return FeedbackComponent.definitiveError(message: 'Tente novamente.');
    } finally {
      resetData();
    }
  }

  getImage() async {
    imagePath.value = await pickImageUtil();
  }

  showBottomAddOrEditPersonal({
    required bool isEdit,
    PersonalNetworkModel? personalNetworkModel,
  }) {
    return showModalBottomSheet(
      context: Get.context!,
      showDragHandle: true,
      backgroundColor: Colors.white,
      isScrollControlled: true,

      builder: (context) {
        return Obx(
          () {
            return SafeArea(
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SizedBox(
                  height: size.height / 1.5,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(800),
                          onTap: () {
                            getImage();
                          },
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: isEdit == true
                                ? (imagePath.value != null
                                      ? FileImage(File(imagePath.value!.path))
                                      : personalNetworkModel!.image == null
                                      ? null
                                      : NetworkImage(
                                          personalNetworkModel.image!,
                                        ))
                                : imagePath.value == null
                                ? null
                                : FileImage(File(imagePath.value!.path)),
                            child:
                                (imagePath.value != null ||
                                    (isEdit == true &&
                                        personalNetworkModel!.image != null))
                                ? null
                                : Icon(
                                    Icons.photo_camera_outlined,
                                    size: 55,
                                  ),
                          ),
                        ),

                        SizedBox(height: 20),

                        TextFormFieldComponent(
                          textEditingController: nameController,
                          labelText: 'Nome',
                          icon: Icons.person_outline_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira um nome válido';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 15),

                        TextFormFieldComponent(
                          textEditingController: phoneNumberController,
                          labelText: 'Telefone (WhatsApp)',
                          icon: Icons.phone_enabled_outlined,
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 14) {
                              return 'Telefone inválido';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 15),

                        TextFormFieldComponent(
                          textEditingController: emailController,
                          labelText: 'E-mail',
                          icon: Icons.email_outlined,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null) {
                              return null;
                            }

                            if (value.isNotEmpty &&
                                (!value.contains('@') ||
                                    !value.contains('.'))) {
                              return 'E-mail inválido. Certifique-se de incluir “@” e “.”';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        Obx(
                          () => ButtonsComponent.buttonFilled(
                            isLoading: isLoadingAddPersonal.value,
                            function: () {
                              if (isEdit == true) {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                Get.back();
                              } else {
                                addPersonalNetwork();
                              }
                            },
                            title: 'Adicionar',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<String> uploadImage() async {
    String imageName = Random().nextDouble().toString();

    final ref = FirebaseStorage.instance.ref().child('imagesPersonalNetwork/$imageName.jpg');

    await ref.putFile(File(imagePath.value!.path));

    final String url = await ref.getDownloadURL();

    return url;
  }

  editContact({
    required PersonalNetworkModel personalNetworkModel,
  }) async {
    emailController.text = personalNetworkModel.email ?? '';
    nameController.text = personalNetworkModel.name;
    phoneNumberController.text = personalNetworkModel.phoneNumber;

    await showBottomAddOrEditPersonal(
      isEdit: true,
      personalNetworkModel: personalNetworkModel,
    );

    if (personalNetworkModel.name != nameController.text ||
        personalNetworkModel.email != emailController.text ||
        personalNetworkModel.phoneNumber != phoneNumberController.text ||
        imagePath.value != null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      String? image;

      if (imagePath.value != null) {
        image = await uploadImage();
      }

      PersonalNetworkModel newPersonalNetwork = PersonalNetworkModel(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        image: image,
      );

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('personalNetwork')
            .doc(personalNetworkModel.docId)
            .update(newPersonalNetwork.toJson());

        FeedbackComponent.successfulAction(
          message: 'Dados de contato salvos com sucesso',
        );
      } on FirebaseException {
        FeedbackComponent.definitiveError(message: 'Tente novamente');
      }
    }

    resetData();
  }

  resetData() {
    nameController.clear();
    phoneNumberController.clear();
    emailController.clear();
    imagePath.value = null;
    isLoadingAddPersonal.value = false;
  }

  deletePersonal(PersonalNetworkModel personalNetworkModel) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    FeedbackComponent.confirmationAction(
      content: 'Esta ação é irreversível. Tem certeza de que deseja continuar?',
      function: () async {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('personalNetwork')
              .doc(personalNetworkModel.docId)
              .delete();

          Get.back();

          FeedbackComponent.successfulAction(
            message:
                '${personalNetworkModel.name} foi removido(a) com sucesso da sua rede.',
          );
        } catch (_) {
          FeedbackComponent.definitiveError(message: 'Tente novamente');
        }
      },
    );
  }
}
