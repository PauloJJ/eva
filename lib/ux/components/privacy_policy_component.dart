import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyComponent extends StatelessWidget {
  const PrivacyPolicyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Ao se cadastrar, você concorda com nossos termos',
            style: GoogleFonts.poppins(
              color: color.onTertiaryFixed,
            ),
          ),
          TextSpan(
            text: ' Termos de Uso',
            style: GoogleFonts.poppins(
              color: color.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' e ',
            style: GoogleFonts.poppins(
              color: color.onTertiaryFixed,
            ),
          ),
          TextSpan(
            text: 'Política de Privacidade',
            style: GoogleFonts.poppins(
              color: color.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
