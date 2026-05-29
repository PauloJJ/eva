import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.secondary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: EasyDateTimeLinePicker.itemBuilder(
        headerOptions: HeaderOptions(headerType: HeaderType.none),
        timelineOptions: TimelineOptions(height: 120),
        focusedDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2090),
        onDateChange: (date) {},
        itemExtent: 60,
        itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
          return Container(
            decoration: BoxDecoration(
              color: isSelected == true ? Color(0xFFDCBFF8) : null,
              borderRadius: BorderRadius.circular(800),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('MMMM').format(date),
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected == true ? Colors.black : Colors.grey,
                  ),
                ),

                SizedBox(height: 5),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(800),
                    border: isSelected == true
                        ? null
                        : Border.all(color: color.primaryContainer),
                    color: isSelected == true ? Colors.white : null,
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
                  DateFormat('EE').format(date),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected == true ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
