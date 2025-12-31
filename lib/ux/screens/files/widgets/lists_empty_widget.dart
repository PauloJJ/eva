import 'package:eva/themes/app_text_style_theme.dart';
import 'package:flutter/material.dart';

class ListsEmptyWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const ListsEmptyWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 120,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: AppTextStyleTheme.title.apply(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
