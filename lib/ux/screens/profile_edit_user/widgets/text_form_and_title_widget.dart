import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/text_form_field_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormAndTitleWidget extends StatelessWidget {
  final String title;

  final IconData icon;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final bool? enabled;
  final String? Function(String?)? validator;

  const TextFormAndTitleWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    this.textInputFormatter,
    this.enabled,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyleTheme.title,
        ),

        SizedBox(height: 10),

        TextFormFieldComponent(
          labelText: null,
          icon: icon,
          textEditingController: controller,
          inputFormatters: textInputFormatter,
          enabled: enabled,
          validator: (value) {
            if (validator == null) {
              return null;
            }

            return validator!(value);
          },
        ),
      ],
    );
  }
}
