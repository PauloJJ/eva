import 'package:brasil_fields/brasil_fields.dart';
import 'package:eva/services/admob_service.dart';
import 'package:eva/services/criminal_record_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:eva/ux/screens/criminal_record/widgets/result_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CriminalRecordScreen extends StatelessWidget {
  CriminalRecordScreen({super.key});

  final CriminalRecordService criminalRecordService = Get.put(
    CriminalRecordService(),
  );

  final userCpfController = TextEditingController();
  final nameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final cpfController = TextEditingController();
  final mothersNameController = TextEditingController();
  final fathersNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nada consta'),
      ),
      body: Obx(() {
        if (criminalRecordService.resultCriminalRecordModel.value != null) {
          return ResultWidget();
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 210,
                    width: size.width,
                    color: color.secondary,
                    padding: EdgeInsets.only(top: 20),
                    child: Hero(
                      tag: 'image_police_01',
                      child: Image.asset(
                        'assets/images/actions_component_07.png',
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: criminalRecordService.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pesquisar Antecedentes criminais',
                            textAlign: TextAlign.center,
                            style: AppTextStyleTheme.h2,
                          ),

                          SizedBox(height: 10),

                          Text(
                            'É permitido realizar apenas uma pesquisa por dia. Mesmo sem resultados, a consulta será consumida.',
                            textAlign: TextAlign.center,
                            style: AppTextStyleTheme.subTitle,
                          ),

                          SizedBox(height: 25),

                          TextFormFieldComponent(
                            textEditingController: userCpfController,
                            labelText: 'Seu CPF',
                            icon: Icons.document_scanner_outlined,
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

                          SizedBox(height: 40),

                          Text(
                            'Dados da pessoa a ser consultada',
                            style: AppTextStyleTheme.title,
                          ),

                          SizedBox(height: 10),

                          TextFormFieldComponent(
                            textEditingController: nameController,
                            inputFormatters: [
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => TextEditingValue(
                                  text: newValue.text.toUpperCase(),
                                ),
                              ),
                            ],
                            labelText: 'Nome Completo',
                            icon: Icons.person_outline,
                            obscureText: false,
                            help: Text(
                              'Não utilize acentos ou caracteres especiais',
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira um nome válido';
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 25),

                          TextFormFieldComponent(
                            textEditingController: dateOfBirthController,
                            labelText: 'Data de Nascimento',
                            icon: Icons.date_range,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              DataInputFormatter(),
                            ],
                            obscureText: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10) {
                                return 'Insira uma data válida';
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 25),

                          TextFormFieldComponent(
                            textEditingController: cpfController,
                            labelText: 'CPF',
                            icon: Icons.document_scanner_outlined,
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

                          SizedBox(height: 25),

                          TextFormFieldComponent(
                            textEditingController: fathersNameController,
                            labelText: 'Nome completo do Pai',
                            icon: Icons.person_outline,
                            obscureText: false,
                            inputFormatters: [
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => TextEditingValue(
                                  text: newValue.text.toUpperCase(),
                                ),
                              ),
                            ],
                            help: Text(
                              'Não utilize acentos ou caracteres especiais',
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira um nome válido';
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 25),

                          TextFormFieldComponent(
                            textEditingController: mothersNameController,
                            labelText: 'Nome completo da Mãe',
                            icon: Icons.person_outline,
                            obscureText: false,
                            inputFormatters: [
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => TextEditingValue(
                                  text: newValue.text.toUpperCase(),
                                ),
                              ),
                            ],
                            help: Text(
                              'Não utilize acentos ou caracteres especiais',
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira um nome válido';
                              }

                              return null;
                            },
                          ),

                          SizedBox(height: 30),

                          ButtonsComponent.buttonFilled(
                            isLoading: criminalRecordService.isLoading.value,
                            title: 'Assistir Ad e Buscar',
                            function: () {
                              AdmobService admobService =
                                  Get.find<AdmobService>();

                              admobService.showIntersticialGeneral(true);

                              criminalRecordService.getCriminalRecords(
                                userCpf: userCpfController.text,
                                name: nameController.text,
                                dateOfBirth: dateOfBirthController.text,
                                cpf: cpfController.text,
                                mothersName: mothersNameController.text,
                                fathersName: fathersNameController.text,
                              );
                            },
                          ),

                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
