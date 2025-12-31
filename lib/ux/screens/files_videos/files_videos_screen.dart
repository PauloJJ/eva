import 'package:eva/ux/components/view_list_videos_files_component.dart';
import 'package:flutter/material.dart';

class FilesVideosScreen extends StatelessWidget {
  const FilesVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ViewListVideosFilesComponent(isPreviewList: false),
          ),
        ),
      ),
    );
  }
}
