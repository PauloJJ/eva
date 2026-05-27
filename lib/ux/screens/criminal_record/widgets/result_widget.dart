import 'package:eva/models/result_criminal_record_model.dart';
import 'package:eva/services/criminal_record_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ResultWidget extends StatelessWidget {
  ResultWidget({super.key});

  final CriminalRecordService criminalRecordService = Get.find();

  @override
  Widget build(BuildContext context) {
    ResultCriminalRecordModel resultCriminalRecordModel =
        criminalRecordService.resultCriminalRecordModel.value!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: resultCriminalRecordModel.message == 'Nada consta.'
                    ? color.secondary
                    : Colors.red.withAlpha(70),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                title: Text(
                  resultCriminalRecordModel.message,
                  style: AppTextStyleTheme.title,
                ),
                leading: CircleAvatar(
                  backgroundColor:
                      resultCriminalRecordModel.message == 'Nada consta.'
                      ? Colors.green
                      : Colors.red,
                  child: resultCriminalRecordModel.message == 'Nada consta.'
                      ? Icon(
                          Icons.check,
                        )
                      : Icon(
                          Icons.close,
                        ),
                ),
              ),
            ),

            Spacer(),

            ButtonsComponent.buttonFilled(
              title: 'Voltar',
              function: () {
                Get.back();
              },
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
