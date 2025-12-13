import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class AvailableCardsWidget extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function() function;

  const AvailableCardsWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: color.tertiary,
        ),
      ),
      elevation: 0,
      margin: EdgeInsets.all(0),
      child: SizedBox(
        width: size.width,
        child: ListTile(
          onTap: () {
            function();
          },
          leading: Icon(
            iconData,
            size: 30,
            color: color.tertiary,
          ),
          title: Text(
            title,
            style: AppTextStyleTheme.title02.apply(
              color: color.tertiary,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward,
            color: color.tertiary,
          ),
        ),
      ),
    );
  }
}
