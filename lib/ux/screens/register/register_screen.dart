import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/auth_app_service.dart';
import 'package:eva/utils/pick_image_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/privacy_policy_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthAppService authAppService = Get.find();

  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text('Inscrever-se'),
          ),
          body: Form(
            key: authAppService.formKeyRegister,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          authAppService.image.value = await pickImageUtil();
                        },
                        borderRadius: BorderRadius.circular(800),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  authAppService.image.value == null
                                  ? null
                                  : FileImage(
                                      File(authAppService.image.value!.path),
                                    ),
                              child: authAppService.image.value != null
                                  ? null
                                  : Icon(
                                      Icons.photo_camera_outlined,
                                      size: 55,
                                    ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 15,
                              child: CircleAvatar(
                                backgroundColor: color.primaryFixed,
                                radius: 22,
                                child: IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.photo_camera_outlined,
                                    size: 25,
                                    color: color.primaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40),

                      TextFormFieldComponent(
                        textEditingController: nameController,
                        labelText: 'Nome completo',
                        icon: Icons.person_outline,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira um nome válido';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      TextFormFieldComponent(
                        textEditingController: cpfController,
                        labelText: 'Cpf',
                        icon: Icons.email_outlined,
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 14) {
                            return 'O CPF informado não é válido';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

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

                      SizedBox(height: 20),

                      TextFormFieldComponent(
                        textEditingController: emailController,
                        labelText: 'E-mail',
                        icon: Icons.email_outlined,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@') ||
                              !value.contains(
                                '.',
                              )) {
                            return 'E-mail inválido. Certifique-se de incluir “@” e “.”';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      TextFormFieldComponent(
                        textEditingController: passwordController,
                        labelText: 'Senha',
                        icon: Icons.lock_outline,
                        obscureText: true,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Senha inválida';
                          }

                          if (value.length < 6) {
                            return 'A senha deve ter pelo menos 6 caracteres';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      TextFormFieldComponent(
                        textEditingController: confirmPasswordController,
                        labelText: 'Confirme a senha',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'As senhas não coincidem';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 30),

                      authAppService.isLoadingRegister.value == true
                          ? Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                ButtonsComponent.buttonFilled(
                                  title: 'Inscrever-se',
                                  function: () {
                                    authAppService.registerUser(
                                      password: passwordController.text,
                                      userModel: UserModel(
                                        name: nameController.text,
                                        cpf: cpfController.text,
                                        phoneNumber: phoneNumberController.text,
                                        email: emailController.text,
                                        pushToken: null,
                                        profileImage: 'profileImage',
                                        volunteerFairyGodmonther: false,
                                        accountDeleted: false,
                                        didTheTutorial: false,
                                        lastSosActivated: DateTime.timestamp(),
                                        accountCreationDate:
                                            DateTime.timestamp(),
                                        currentLocation: null,
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(height: 10),

                                ButtonsComponent.buttonTextButon(
                                  title: 'Fazer Login',
                                  function: () {
                                    Get.back();
                                  },
                                  sizeText: 18,
                                ),
                              ],
                            ),

                      SizedBox(height: 20),

                      PrivacyPolicyComponent(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
