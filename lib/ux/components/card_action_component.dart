import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class CardActionComponent extends StatelessWidget {
  final String title;
  final String image;
  final Function() function;

  const CardActionComponent({
    super.key,
    required this.title,
    required this.image,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: color.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Image.asset(
            image,
            height: 90,
          ),
          title: Text(
            title,
            style: AppTextStyleTheme.title,
          ),
          trailing: Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
      ),
    );
  }
}
