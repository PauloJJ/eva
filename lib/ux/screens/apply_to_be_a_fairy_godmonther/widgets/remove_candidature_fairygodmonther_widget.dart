import 'package:eva/services/remove_or_add_candidature_fairy_godmonther_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoveCandidatureFairygodmontherWidget extends StatelessWidget {
  RemoveCandidatureFairygodmontherWidget({super.key});

  final RemoveOrAddCandidatureFairyGodmontherService
  removeOrAddCandidatureFairyGodmontherService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ButtonsComponent.buttonFilled(
          title: 'Remover Candidatura',
          color: Colors.red,
          function: () {
            removeOrAddCandidatureFairyGodmontherService
                .removeCandidatureFairyGodmonther();
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),

                Image.asset(
                  'assets/images/fairy_godmonther.png',
                  height: 250,
                ),

                SizedBox(height: 20),

                Text(
                  'Remover Candidatura',
                  textAlign: TextAlign.center,
                  style: AppTextStyleTheme.h1,
                ),

                SizedBox(height: 10),

                Text(
                  'Se você remover a candidatura, outras mulheres não poderão mais entrar em contato com você.',
                  textAlign: TextAlign.center,
                  style: AppTextStyleTheme.subTitle,
                ),

                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
