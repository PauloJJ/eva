import 'package:eva/ux/components/view_list_audio_file_component.dart';
import 'package:eva/ux/components/view_list_photos_files_component.dart';
import 'package:eva/ux/components/view_list_videos_files_component.dart';
import 'package:flutter/material.dart';

class ViewListFilesScreen extends StatelessWidget {
  final String wichList;

  const ViewListFilesScreen({
    super.key,
    required this.wichList,
  });

  Widget getWidgets() {
    if (wichList == 'Fotos') {
      return ViewListPhotosFilesComponent(isPreviewList: false);
    } else if (wichList == 'Vídeos') {
      return ViewListVideosFilesComponent(isPreviewList: false);
    } else {
      return ViewListAudioFileComponent(isPreviewList: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Áudios'),
      ),
      body: SafeArea(
        child: getWidgets(),
      ),
    );
  }
}
