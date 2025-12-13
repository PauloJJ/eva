import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class CardsInformationWidget extends StatelessWidget {
  final String title;
  final IconData iconData;

  const CardsInformationWidget({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.tertiaryContainer,
      child: SizedBox(
        width: size.width / 3.6,
        height: 125,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyleTheme.title.apply(
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: color.secondary,
                    ),

                    Icon(
                      iconData,
                      color: color.secondary,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
