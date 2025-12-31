import 'package:eva/ux/components/view_list_audio_file_component.dart';
import 'package:flutter/material.dart';

class FilesAudiosScreen extends StatelessWidget {
  const FilesAudiosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Áudios'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ViewListAudioFileComponent(isPreviewList: false),
          ),
        ),
      ),
    );
  }
}
