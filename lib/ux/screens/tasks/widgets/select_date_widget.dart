import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:eva/services/task_service.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class SelectDateWidget extends StatelessWidget {
  SelectDateWidget({super.key});

  final TaskService taskService = Get.find();

  final tz.TZDateTime dateNow = tz.TZDateTime.now(tz.local);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          decoration: BoxDecoration(
            color: color.secondary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 25),
          child: EasyDateTimeLinePicker.itemBuilder(
            headerOptions: HeaderOptions(
              headerType: HeaderType.none,
            ),
            timelineOptions: TimelineOptions(height: 120),
            focusedDate: taskService.dateSelect.value,
            firstDate: DateTime(2015),
            lastDate: DateTime(2090),
            itemExtent: 60,
            locale: const Locale('pt', 'BR'),
            onDateChange: (date) {
              taskService.dateSelect.value = date;
            },

            itemBuilder:
                (context, date, isSelected, isDisabled, isToday, onTap) {
                  String nowDate = DateFormat('dd/MM/yyyy').format(dateNow);
                  String dateTimeLine = DateFormat('dd/MM/yyyy').format(date);

                  return InkWell(
                    onTap: () {
                      onTap();

                      taskService.dateSelect.value = date;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected == true
                            ? Color(0xFFDCBFF8)
                            : nowDate == dateTimeLine
                            ? Color(0xFFDCBFF8).withAlpha(120)
                            : null,
                        borderRadius: BorderRadius.circular(800),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('MMM', 'pt_BR').format(date),
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected == true
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),

                          SizedBox(height: 5),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(800),
                              border: isSelected == true
                                  ? null
                                  : Border.all(color: color.primaryContainer),
                              color: isSelected == true
                                  ? Colors.white
                                  : nowDate == dateTimeLine
                                  ? Colors.white.withAlpha(120)
                                  : null,
                            ),
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(
                                child: Text(
                                  DateFormat('dd').format(date),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected == true
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            DateFormat('EE', 'pt_BR').format(date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected == true
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
          ),
        );
      },
    );
  }
}
