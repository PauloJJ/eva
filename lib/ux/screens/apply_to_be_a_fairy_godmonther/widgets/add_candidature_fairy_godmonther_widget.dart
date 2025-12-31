import 'package:eva/services/remove_or_add_candidature_fairy_godmonther_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCandidatureFairyGodmontherWidget extends StatelessWidget {
  AddCandidatureFairyGodmontherWidget({super.key});

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
          title: 'Se candidatar',
          function: () {
            removeOrAddCandidatureFairyGodmontherService
                .appliedToBeAFairygodmother();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),

                    Image.asset(
                      'assets/images/fairy_godmonther.png',
                      height: 230,
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Candidate-se para ser Voluntária',
                      textAlign: TextAlign.center,
                      style: AppTextStyleTheme.h1,
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Na Eva, você pode apoiar outras mulheres se cadastrando como voluntária e deixando seu contato disponível para quem precisar falar com você.',
                      textAlign: TextAlign.center,
                      style: AppTextStyleTheme.subTitle,
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
          );
        },
      ),
    );
  }
}
