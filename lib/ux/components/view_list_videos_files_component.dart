import 'package:eva/models/video_model.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/screens/files/widgets/lists_empty_widget.dart';
import 'package:eva/ux/screens/files_videos/files_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewListVideosFilesComponent extends StatelessWidget {
  final bool isPreviewList;

  ViewListVideosFilesComponent({
    super.key,
    required this.isPreviewList,
  });

  final FilesService filesService = Get.find();

  length() {
    final list = filesService.listPathVideo.value;

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
        List<Map<String, dynamic>> listPathVideo =
            filesService.listPathVideo.value;

        return Column(
          children: [
            if (isPreviewList == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vídeos',
                    style: AppTextStyleTheme.title02,
                  ),
                  ButtonsComponent.buttonTextButon(
                    title: 'Ver tudo',
                    function: () {
                      Get.to(() => FilesVideosScreen());
                    },
                  ),
                ],
              ),

            if (listPathVideo.isEmpty) ...[
              ListsEmptyWidget(
                title: 'Nenhum vídeo',
                icon: Icons.video_camera_back_outlined,
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
                mainAxisExtent: 130,
              ),
              itemCount: length(),
              itemBuilder: (context, index) {
                VideoModel videoModel = VideoModel.fromJson(
                  listPathVideo[index],
                );

                return InkWell(
                  onTap: () {
                    if (isPreviewList == true) {
                      filesService.navigatorFileScreen(
                        filePath: videoModel.path,
                        index: index,
                        listName: 'video',
                      );
                    } else {
                      filesService.openFile(
                        path: videoModel.path,
                        index: index,
                        listName: 'video',
                      );
                    }
                  },
                  onLongPress: () {
                    FeedbackComponent.confirmationAction(
                      content:
                          'Você está prestes a excluir este arquivo. Tem certeza de que deseja continuar?',
                      function: () {
                        filesService.deleFile(
                          listName: 'video',
                          index: index,
                        );

                        Get.back();
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      color: color.secondary,
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.videocam_outlined,
                          color: color.secondaryContainer,
                          size: 50,
                        ),

                        SizedBox(height: 5),

                        Text(
                          DateFormat('dd/MM/yyyy HH:mm').format(
                            DateTime.parse(videoModel.date),
                          ),
                          textAlign: TextAlign.center,
                          style: AppTextStyleTheme.subTitle.apply(
                            color: color.secondaryContainer,
                          ),
                        ),
                      ],
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
