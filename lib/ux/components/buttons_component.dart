import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonsComponent extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function() function;
  final bool? isOutline;
  final double? height;
  final double? width;
  final Color? color;
  final bool? isLoading;

  const ButtonsComponent({
    super.key,
    required this.title,
    this.icon,
    required this.function,
    this.isOutline,
    this.height,
    this.width,
    this.color,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutline == true) {
      return isLoading == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  color: color ?? Get.theme.colorScheme.primaryContainer,
                ),
              ),
              onPressed: function,
              icon: icon == null
                  ? null
                  : Icon(
                      icon,
                      size: 30,
                    ),
              label: SizedBox(
                height: height ?? 50,
                width: width,
                child: Center(
                  child: Text(
                    title,
                    style: textStyle.titleLarge,
                  ),
                ),
              ),
            );
    } else {
      return isLoading == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : FilledButton.icon(
              onPressed: function,
              icon: icon == null
                  ? null
                  : Icon(
                      icon,
                      size: 30,
                    ),
              label: SizedBox(
                height: height ?? 50,
                child: Center(
                  child: Text(
                    title,
                    style: textStyle.titleLarge,
                  ),
                ),
              ),
            );
    }
  }
}
