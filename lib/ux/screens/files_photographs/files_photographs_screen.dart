import 'package:eva/ux/components/view_list_photos_files_component.dart';
import 'package:flutter/material.dart';

class FilesPhotographsScreen extends StatelessWidget {
  const FilesPhotographsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotografias'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ViewListPhotosFilesComponent(isPreviewList: false),
          ),
        ),
      ),
    );
  }
}
