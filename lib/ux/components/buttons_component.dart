import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonsComponent {
  static Widget buttonOutline({
    required String title,
    required Function() function,
    bool? isLoading,
    IconData? icon,
    Color? color,
    double? sizeText,
    double? height,
    double? width,
  }) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : OutlinedButton.icon(
            iconAlignment: IconAlignment.end,
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
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
  }

  static Widget buttonFilled({
    required String title,
    required Function() function,
    bool? isLoading,
    IconData? icon,
    Color? color,
    double? sizeText,
    double? height,
    double? width,
  }) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : FilledButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: color ?? Get.theme.colorScheme.primaryContainer,
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
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
  }

  static Widget buttonTextButon({
    required String title,
    required Function() function,
    bool? isLoading,
    IconData? icon,
    Color? color,
    double? sizeText,
    double? height,
    double? width,
  }) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : TextButton.icon(
            onPressed: function,
            icon: icon == null
                ? null
                : Icon(
                    icon,
                    size: 30,
                  ),
            label: Text(
              title,
              style: TextStyle(
                fontSize: sizeText ?? 15,
                color: color,
              ),
            ),
          );
  }

  static negativeButtonOutiline({
    required String title,
    required Function() function,
    bool? isLoading,
    IconData? icon,
    double? sizeText,
    double? height,
    double? width,
  }) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : OutlinedButton.icon(
            iconAlignment: IconAlignment.end,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: Colors.red),
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
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          );
  }
}
