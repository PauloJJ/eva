import 'package:brasil_fields/brasil_fields.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/screens/profile_edit_user/widgets/text_form_and_title_widget.dart';
import 'package:eva/ux/screens/reset_password/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileEditUserScreen extends StatefulWidget {
  const ProfileEditUserScreen({super.key});

  @override
  State<ProfileEditUserScreen> createState() => _ProfileEditUserScreenState();
}

class _ProfileEditUserScreenState extends State<ProfileEditUserScreen> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();

  final UserService userService = Get.find();

  final formKey = GlobalKey<FormState>();

  String selectedCountry = '+55';

  @override
  void initState() {
    UserModel userModel = userService.userModel.value!;

    nameController.text = userModel.name;
    numberController.text = userModel.phoneNumber;
    emailController.text = userModel.email;
    cpfController.text = userModel.cpf;
    selectedCountry = userModel.countryCode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Obx(
        () {
          UserModel userModel = userService.userModel.value!;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(800),
                        onTap: () {
                          userService.updatePhoto();
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                userModel.profileImage,
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: CircleAvatar(
                                radius: 26,
                                child: Icon(Icons.add_a_photo_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),
                      TextFormAndTitleWidget(
                        title: 'Nome Completo',
                        icon: Icons.person_outline_rounded,
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira um nome válido.';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],

                        decoration: InputDecoration(
                          prefixIcon: CountryCodePicker(
                            headerText: 'Seletor de país',
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: color.onSecondary,
                              fontSize: 16,
                            ),
                            initialSelection: selectedCountry,

                            onChanged: (value) {
                              selectedCountry = value.dialCode!;
                              setState(() {});
                            },
                          ),

                          label: Text(
                            'Telefone (WhatsApp)',
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 14) {
                            return 'Senha inválida';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      TextFormAndTitleWidget(
                        title: 'E-mail',
                        icon: Icons.email_outlined,
                        controller: emailController,
                        textInputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        enabled: false,
                      ),

                      SizedBox(height: 20),

                      TextFormAndTitleWidget(
                        title: 'CPF',
                        icon: Icons.document_scanner_outlined,
                        controller: cpfController,
                        textInputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        enabled: false,
                      ),

                      SizedBox(height: 10),

                      Row(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: ButtonsComponent.buttonTextButon(
                              title: 'Alterar Senha',
                              function: () {
                                Get.to(() => ResetPasswordScreen());
                              },
                            ),
                          ),

                          Spacer(),

                          ButtonsComponent.buttonTextButon(
                            title: 'Excluir conta',
                            function: () {},
                            color: Colors.red,
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      ButtonsComponent.buttonFilled(
                        title: 'Salvar',
                        function: () {
                          userService.updateDatas(
                            name: nameController.text,
                            phoneNumber: numberController.text,
                            formKey: formKey,
                            selectedCountry: selectedCountry,
                          );
                        },
                      ),

                      SizedBox(height: 10),
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
