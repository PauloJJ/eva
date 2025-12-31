import 'package:eva/models/audio_model.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/screens/audio_player/audio_player_screen.dart';
import 'package:eva/ux/screens/files/widgets/lists_empty_widget.dart';
import 'package:eva/ux/screens/files_audios/files_audios_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewListAudioFileComponent extends StatelessWidget {
  final bool isPreviewList;

  ViewListAudioFileComponent({
    super.key,
    required this.isPreviewList,
  });

  final FilesService filesService = Get.find();

  length() {
    final list = filesService.listPathAudio.value;

    if (isPreviewList == true) {
      return (list.length > 4 ? 4 : list.length);
    } else {
      return list.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<Map<String, dynamic>> listPathAudio =
            filesService.listPathAudio.value;

        return Column(
          children: [
            if (isPreviewList == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Áudios',
                    style: AppTextStyleTheme.title02,
                  ),

                  ButtonsComponent.buttonTextButon(
                    title: 'Ver tudo',
                    function: () {
                      Get.to(() => FilesAudiosScreen());
                    },
                  ),
                ],
              ),

            if (listPathAudio.isEmpty) ...[
              ListsEmptyWidget(
                title: 'Nenhum áudio',
                icon: Icons.multitrack_audio_rounded,
              ),
            ],

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: length(),
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                AudioModel audioModel = AudioModel.fromJson(
                  listPathAudio[index],
                );

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      if (isPreviewList == true) {
                        filesService.navigatorFileScreen(
                          filePath: audioModel.path,
                          index: index,
                          listName: 'audio',
                        );
                      } else {
                        Get.to(() => AudioPlayerScreen(path: audioModel.path));
                      }
                    },
                    onLongPress: () {
                      FeedbackComponent.confirmationAction(
                        content:
                            'Você está prestes a excluir este arquivo. Tem certeza de que deseja continuar?',
                        function: () {
                          filesService.deleFile(
                            listName: 'audios',
                            index: index,
                          );

                          Get.back();
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color.secondary,
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.multitrack_audio_rounded,
                          color: color.secondaryContainer,
                          size: 35,
                        ),
                        title: Text(
                          audioModel.audioTimer,
                        ),
                        trailing: Text(
                          DateFormat(
                            'dd/MM/yyyy HH:mm',
                          ).format(
                            DateTime.parse(audioModel.date),
                          ),
                          style: AppTextStyleTheme.subTitle,
                        ),
                      ),
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
