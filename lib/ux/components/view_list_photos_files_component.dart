import 'dart:io';
import 'package:eva/services/files_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/screens/files/widgets/lists_empty_widget.dart';
import 'package:eva/ux/screens/files_photographs/files_photographs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewListPhotosFilesComponent extends StatelessWidget {
  final bool isPreviewList;

  ViewListPhotosFilesComponent({
    super.key,
    required this.isPreviewList,
  });

  final FilesService filesService = Get.find();

  length() {
    List<String> list = filesService.listPathPhotographs.value;

    if (isPreviewList == true) {
      return (list.length > 6 ? 6 : list.length);
    } else {
      return list.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<String> listPathPhotographs =
            filesService.listPathPhotographs.value;

        return Column(
          children: [
            if (isPreviewList == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fotografias',
                    style: AppTextStyleTheme.title02,
                  ),
                  ButtonsComponent.buttonTextButon(
                    title: 'Ver tudo',
                    function: () {
                      Get.to(() => FilesPhotographsScreen());
                    },
                  ),
                ],
              ),

            if (listPathPhotographs.isEmpty) ...[
              ListsEmptyWidget(
                title: 'Nenhum foto',
                icon: Icons.photo_camera_back_outlined,
              ),
            ],

            GridView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: length(),
              itemBuilder: (context, index) {
                String path = filesService.listPathPhotographs.value[index];

                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onLongPress: () {
                    FeedbackComponent.confirmationAction(
                      content:
                          'Você está prestes a excluir este arquivo. Tem certeza de que deseja continuar?',
                      function: () {
                        filesService.deleFile(
                          listName: 'photographs',
                          index: index,
                        );

                        Get.back();
                      },
                    );
                  },
                  onTap: () {
                    if (isPreviewList == true) {
                      filesService.navigatorFileScreen(
                        filePath: path,
                        index: index,
                        listName: 'photographs',
                      );
                    } else {
                      filesService.openFile(
                        path: path,
                        index: index,
                        listName: 'photographs',
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: Image.file(
                      File(path),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
