import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String? labelText;
  final IconData icon;
  final bool? obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final bool? enabled;
  final String? hint;

  const TextFormFieldComponent({
    super.key,
    required this.labelText,
    required this.icon,
    this.obscureText,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.keyboardType,
    this.textEditingController,
    this.enabled,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: textEditingController,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hint: Text(hint ?? ''),
        prefixIcon: Icon(
          icon,
          color: color.primaryContainer,
        ),
        suffixIcon: suffixIcon,
        label: Text(
          labelText ?? '',
        ),
      ),
      validator: (value) {
        if (validator == null) {
          return null;
        }

        return validator!(value);
      },
    );
  }
}
