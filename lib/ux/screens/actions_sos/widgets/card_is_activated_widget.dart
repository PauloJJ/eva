import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class CardIsActivatedWidget extends StatelessWidget {
  const CardIsActivatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.power_settings_new_rounded,
            color: Colors.white,
            size: 35,
          ),

          SizedBox(width: 10),

          Text(
            'SOS ATIVADO',
            style: AppTextStyleTheme.title02.apply(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
