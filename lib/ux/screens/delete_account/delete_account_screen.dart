import 'package:eva/services/auth_app_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excluir'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/delete_account.png',
                    height: 250,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Você está prestes a excluir sua conta',
                  textAlign: TextAlign.center,
                  style: AppTextStyleTheme.h2,
                ),

                SizedBox(height: 10),

                Text(
                  'Tem certeza de que deseja continuar? Esta ação é irreversível e sua conta será excluída permanentemente.',
                  textAlign: TextAlign.center,
                  style: AppTextStyleTheme.subTitle,
                ),

                SizedBox(height: 20),

                Form(
                  key: formKey,
                  child: TextFormFieldComponent(
                    textEditingController: passwordController,
                    labelText: 'Senha',
                    icon: Icons.lock_open,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A senha informada é inválida. Tente novamente.';
                      }

                      return null;
                    },
                  ),
                ),

                SizedBox(height: 40),

                ButtonsComponent.buttonFilled(
                  title: 'Excluir conta',
                  color: Colors.red,
                  function: () {
                    AuthAppService authAppService = Get.find();

                    authAppService.deleteAccount(
                      password: passwordController.text,
                      formKey: formKey,
                    );
                  },
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
