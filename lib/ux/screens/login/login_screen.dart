import 'package:eva/services/auth_app_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/privacy_policy_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:eva/ux/screens/register/register_screen.dart';
import 'package:eva/ux/screens/reset_password/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthAppService authAppService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool viewPassword = authAppService.viewPassword.value;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: authAppService.formKeyLogin,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Fazer Login',
                        style: AppTextStyleTheme.h3,
                      ),

                      SizedBox(height: 30),

                      Image.asset(
                        'assets/images/logo_transparente.png',
                        height: 220,
                      ),

                      SizedBox(height: 40),

                      TextFormFieldComponent(
                        textEditingController: emailController,
                        labelText: 'E-mail',
                        icon: Icons.email_outlined,
                        obscureText: false,
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

                      SizedBox(height: 10),

                      TextFormFieldComponent(
                        textEditingController: passwordController,
                        labelText: 'Senha',
                        icon: Icons.lock_outline,
                        obscureText: viewPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            authAppService.toggleViewPassword();
                          },
                          icon: Icon(
                            viewPassword == true
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
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

                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: ButtonsComponent.buttonTextButon(
                          title: 'Esqueci minha',
                          function: () {
                            Get.to(() => ResetPasswordScreen());
                          },
                        ),
                      ),

                      SizedBox(height: 30),

                      authAppService.isLoadingLogin.value == true
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Column(
                              children: [
                                ButtonsComponent.buttonFilled(
                                  title: 'Fazer Login',
                                  function: () {
                                    authAppService.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  },
                                ),

                                SizedBox(height: 10),

                                ButtonsComponent.buttonTextButon(
                                  title: 'Inscrever-se',
                                  function: () {
                                    Get.to(() => RegisterScreen());
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
