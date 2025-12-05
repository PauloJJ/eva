import 'package:eva/services/auth_app_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthAppService authAppService = Get.find();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isLoadingResetPassword =
            authAppService.isLoadingResetPassword.value;
        return Scaffold(
          appBar: AppBar(
            title: Text('Alterar Senha'),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: authAppService.formKeyResetPassword,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/reset_password.png',
                          height: 250,
                        ),

                        Text(
                          'Redefinir senha',
                          style: AppTextStyleTheme.h1,
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Um e-mail de recuperação será enviado para o seu endereço cadastrado',
                          textAlign: TextAlign.center,
                          style: AppTextStyleTheme.subTitle,
                        ),

                        SizedBox(height: 30),

                        TextFormFieldComponent(
                          labelText: 'Email',
                          icon: Icons.email_outlined,
                          textEditingController: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Insira um e-mail antes de continuar';
                            }

                            if (!value.contains('@') || !value.contains('.')) {
                              return 'E-mail inválido. Certifique-se de incluir “@” e “.”';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 30),

                        ButtonsComponent.buttonFilled(
                          title: 'Enviar',
                          isLoading: isLoadingResetPassword,
                          function: () {
                            authAppService.resetPassword(
                              email: emailController.text,
                            );
                          },
                        ),
                      ],
                    ),
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
