import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SosButtonComponent extends StatelessWidget {
  final String title;
  final double titleSize;
  final String subTitle;
  final void Function() function;
  final void Function()? onLongPressEnd;

  const SosButtonComponent({
    super.key,
    required this.title,
    required this.titleSize,
    required this.subTitle,
    required this.function,
    this.onLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          function();
        },
        onLongPressEnd: (details) {
          if (onLongPressEnd != null) {
            onLongPressEnd!();
          }
        },
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Image.asset(
                  'assets/images/sos_button_component_01.png',
                  height: 240,
                )
                .animate(
                  onPlay: (controller) => controller.loop(reverse: true),
                )
                .scale(
                  begin: Offset(0.98, 0.98),
                  duration: Duration(seconds: 2),
                ),

            Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    fontSize: titleSize,
                    color: Colors.white,
                  ),
                ),

                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyleTheme.title.apply(
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            Image.asset(
                  'assets/images/sos_button_component_02.png',
                  height: 325,
                )
                .animate(
                  onPlay: (controller) {
                    controller.loop(reverse: true);
                  },
                )
                .tint(
                  color: color.secondary.withAlpha(200),
                  duration: Duration(seconds: 2),
                ),
          ],
        ),
      ),
    );
  }
}
