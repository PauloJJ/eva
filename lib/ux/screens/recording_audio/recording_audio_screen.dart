import 'package:eva/services/recording_audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RecordingAudioScreen extends StatelessWidget {
  RecordingAudioScreen({super.key});

  final RecordingAudioService recordingAudioService = Get.put(
    RecordingAudioService(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7A5A8D),
      body: Stack(
        children: [
          Image.asset('assets/images/recording_audio_component_01.png'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(height: 50),

                    Text(
                      'Gravação',
                      style: GoogleFonts.montserrat(
                        fontSize: 33,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      'Em Andamento',
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Obx(
                      () => Text(
                        recordingAudioService.timerString.value,
                        style: GoogleFonts.montserrat(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Lottie.asset(
                      'assets/jsons/recording_audio_component_02.json',
                    ),
                  ],
                ),

                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Finalize a gravação clicando no ',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Botão',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE7C2FF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child:
                                InkWell(
                                      borderRadius: BorderRadius.circular(800),
                                      onTap: () {
                                        recordingAudioService.saveAudio();
                                      },
                                      child: Image.asset(
                                        'assets/images/recording_audio_component_02.png',
                                        height: 120,
                                      ),
                                    )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.loop(reverse: true),
                                    )
                                    .scale(
                                      begin: Offset(0.85, 0.85),

                                      duration: Duration(seconds: 3),
                                    ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFFF0051),
                                radius: 30,
                                child: Icon(Icons.close, size: 35),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
