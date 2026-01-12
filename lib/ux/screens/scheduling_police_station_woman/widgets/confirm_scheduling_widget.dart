import 'package:eva/services/scheduling_police_station_woman_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowConfirmSchedulingWidget extends StatelessWidget {
  final DateTime dateScheduling;
  final String schedulingTime;

  ShowConfirmSchedulingWidget({
    super.key,
    required this.dateScheduling,
    required this.schedulingTime,
  });

  final SchedulingPoliceStationWomanService
  schedulingPoliceStationWomanService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isLoading = schedulingPoliceStationWomanService.isLoading.value;

        bool requestedInTheLastSixMonths = schedulingPoliceStationWomanService
            .requestedInTheLastSixMonths
            .value;

        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            schedulingPoliceStationWomanService.resetData();
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                height: 60,
                child: ButtonsComponent.buttonFilled(
                  isLoading: isLoading,
                  title: 'Confirmar',
                  function: () {
                    schedulingPoliceStationWomanService.registerScheduling(
                      schedulingTime,
                    );
                  },
                ),
              ),
            ),

            appBar: AppBar(
              title: Text('Solicitação de Agendamento'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: schedulingPoliceStationWomanService.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informações',
                              style: AppTextStyleTheme.h3,
                            ),

                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.date_range, size: 30),
                              title: Text(
                                DateFormat('dd/MM/yyyy').format(dateScheduling),
                                style: AppTextStyleTheme.title.apply(
                                  color: color.primary,
                                ),
                              ),
                            ),

                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: Icon(Icons.timer_outlined, size: 30),
                              title: Text(
                                schedulingTime,
                                style: AppTextStyleTheme.title.apply(
                                  color: color.primary,
                                ),
                              ),
                            ),

                            Divider(height: 50),
                            SizedBox(height: 10),

                            Text(
                              'Insira seu endereço',
                              style: AppTextStyleTheme.title,
                            ),

                            SizedBox(height: 15),

                            TextFormFieldComponent(
                              labelText: 'Endereço',
                              textEditingController:
                                  schedulingPoliceStationWomanService
                                      .addressController,
                              icon: Icons.location_on_outlined,
                              validator: (value) {
                                if (value == null) {
                                  return null;
                                }

                                if (value.isEmpty) {
                                  return 'Insira um endereço válido.';
                                } else {
                                  return null;
                                }
                              },
                            ),

                            SizedBox(height: 20),

                            Container(
                              decoration: BoxDecoration(
                                color: color.secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: CheckboxListTile.adaptive(
                                contentPadding: EdgeInsets.all(0),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: requestedInTheLastSixMonths,
                                onChanged: (value) {
                                  schedulingPoliceStationWomanService
                                      .toggleCheckBox(
                                        value!,
                                      );
                                },
                                title: Text(
                                  'Solicitei uma medida protetiva nos últimos seis meses.',
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withAlpha(15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                leading: Icon(
                                  Icons.info_outline,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  'Usaremos seus dados para solicitar o agendamento, que poderá ou não ser confirmado. Você receberá atualizações por WhatsApp ou e-mail.',
                                  style: AppTextStyleTheme.subTitle.apply(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 80),
                          ],
                        ),
                      ),
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
