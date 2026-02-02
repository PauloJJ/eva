import 'package:eva/utils/open_url_and_email_util.dart';
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
          WidgetSpan(
            child: InkWell(
              onTap: () {
                openUrlUtil(
                  'https://www.notion.so/Eva-Detalhes-do-App-2edcfc27ba2180c2a078c10c2539f405?source=copy_link',
                );
              },
              child: Text(
                ' Termos de Uso',
                style: GoogleFonts.poppins(
                  color: color.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          WidgetSpan(
            child: Text(
              ' e ',
              style: GoogleFonts.poppins(
                color: color.onTertiaryFixed,
              ),
            ),
          ),

          WidgetSpan(
            child: InkWell(
              onTap: () {
                openUrlUtil(
                  'https://www.notion.so/Eva-Pol-tica-de-Privacidade-2edcfc27ba2180e29db5fc57eb0677c7?source=copy_link',
                );
              },
              child: Text(
                'Política de Privacidade',
                style: GoogleFonts.poppins(
                  color: color.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
