import 'package:brasil_fields/brasil_fields.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/remove_or_add_candidature_fairy_godmonther_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddCandidatureFairyGodmontherWidget extends StatefulWidget {
  const AddCandidatureFairyGodmontherWidget({super.key});

  @override
  State<AddCandidatureFairyGodmontherWidget> createState() =>
      _AddCandidatureFairyGodmontherWidgetState();
}

class _AddCandidatureFairyGodmontherWidgetState
    extends State<AddCandidatureFairyGodmontherWidget> {
  final RemoveOrAddCandidatureFairyGodmontherService
  removeOrAddCandidatureFairyGodmontherService = Get.find();
  UserService userService = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    UserModel userModel = userService.userModel.value!;

    emailController.text = userModel.email;
    numberController.text = userModel.phoneNumber;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ButtonsComponent.buttonFilled(
          title: 'Se candidatar',
          function: () {
            removeOrAddCandidatureFairyGodmontherService
                .appliedToBeAFairygodmother(
                  email: emailController.text,
                  number: numberController.text,
                );
          },
        ),
      ),

      body: Obx(
        () {
          String categorySelect =
              removeOrAddCandidatureFairyGodmontherService.categorySelect.value;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: removeOrAddCandidatureFairyGodmontherService.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),

                      Image.asset(
                        'assets/images/fairy_godmonther.png',
                        height: 200,
                      ),

                      SizedBox(height: 20),

                      Text(
                        'Candidate-se para ser Voluntária',
                        textAlign: TextAlign.center,
                        style: AppTextStyleTheme.h1,
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Na Eva, você pode apoiar outras mulheres se cadastrando como voluntária',
                        textAlign: TextAlign.center,
                        style: AppTextStyleTheme.subTitle,
                      ),

                      SizedBox(height: 40),

                      Text(
                        'Contato visível para outras pessoas',
                        textAlign: TextAlign.center,
                        style: AppTextStyleTheme.title,
                      ),

                      SizedBox(height: 20),

                      TextFormFieldComponent(
                        labelText: 'E-mail',
                        textEditingController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,
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
                        labelText: 'Número',
                        textEditingController: numberController,
                        icon: Icons.phone,
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value.length < 14) {
                            return 'Senha inválida';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 40),

                      Text(
                        'Escolha sua categoria',
                        style: AppTextStyleTheme.title,
                      ),

                      SizedBox(height: 15),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: removeOrAddCandidatureFairyGodmontherService
                            .filterlist
                            .map(
                              (e) {
                                String category = e;

                                bool isSelect = category == categorySelect
                                    ? true
                                    : false;

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 5,
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(800),
                                    onTap: () {
                                      removeOrAddCandidatureFairyGodmontherService
                                          .selectCategory(
                                            category,
                                          );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelect == true
                                            ? color.primary
                                            : null,
                                        borderRadius: BorderRadius.circular(
                                          800,
                                        ),
                                        border: BoxBorder.all(
                                          color: color.primary,
                                        ),
                                      ),
                                      child: Text(
                                        e,
                                        style: isSelect == true
                                            ? AppTextStyleTheme.title.apply(
                                                color: Colors.white,
                                              )
                                            : AppTextStyleTheme.subTitle,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                            .toList(),
                      ),

                      SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
