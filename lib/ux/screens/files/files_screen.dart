import 'package:eva/services/files_service.dart';
import 'package:eva/ux/components/view_list_audio_file_component.dart';
import 'package:eva/ux/components/view_list_photos_files_component.dart';
import 'package:eva/ux/components/view_list_videos_files_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilesScreen extends StatelessWidget {
  FilesScreen({super.key});

  final FilesService filesService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  ViewListPhotosFilesComponent(isPreviewList: true),

                  SizedBox(height: 40),

                  ViewListVideosFilesComponent(isPreviewList: true),

                  SizedBox(height: 40),

                  ViewListAudioFileComponent(isPreviewList: true),

                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
