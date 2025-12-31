import 'package:eva/services/audio_player_service.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/ux/screens/audio_player/widgets/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String path;

  const AudioPlayerScreen({
    super.key,
    required this.path,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayerService? audioPlayerService;
  FilesService filesService = Get.find();

  @override
  void initState() {
    audioPlayerService = Get.put(AudioPlayerService(path: widget.path));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Voltar',
          style: TextStyle(color: Colors.white),
        ),
      ),
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
                      'Reproduzindo',
                      style: GoogleFonts.montserrat(
                        fontSize: 33,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      'Áudio',
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

                PlayerWidget(
                  audioPlayerService: audioPlayerService!,
                ),

                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Compartilhe sua ',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Gravação',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE7C2FF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    InkWell(
                      onTap: () {
                        filesService.shareFile(widget.path);
                      },
                      borderRadius: BorderRadius.circular(500),
                      child: CircleAvatar(
                        radius: 35,
                        child: Icon(
                          Icons.share,
                          size: 35,
                        ),
                      ),
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
