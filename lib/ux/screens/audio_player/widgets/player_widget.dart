import 'package:eva/services/audio_player_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PlayerWidget extends StatelessWidget {
  final AudioPlayerService audioPlayerService;

  const PlayerWidget({
    super.key,
    required this.audioPlayerService,
  });

  String formatTimer(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: size.width,
        height: 100,
        child: StreamBuilder(
          stream: audioPlayerService.player.onPositionChanged,
          builder: (context, onPositionChanged) {
            return StreamBuilder(
              stream: audioPlayerService.player.onDurationChanged,
              builder: (context, onDurationChanged) {
                if (onPositionChanged.data == null ||
                    onDurationChanged.data == null) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  return Obx(
                    () {
                      String state = audioPlayerService.state.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  audioPlayerService.togglePlayer();
                                },
                                icon: Icon(
                                  state == 'playing'
                                      ? Icons.play_arrow_rounded
                                      : state == 'paused'
                                      ? Icons.pause
                                      : Icons.refresh,
                                  size: 40,
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  children: [
                                    Slider.adaptive(
                                      min: 0.0,
                                      max: onDurationChanged
                                          .data!
                                          .inMilliseconds
                                          .toDouble(),
                                      value: onPositionChanged
                                          .data!
                                          .inMilliseconds
                                          .toDouble(),
                                      onChanged: (value) async {
                                        try {
                                          await audioPlayerService.player.seek(
                                            Duration(
                                              milliseconds: value.toInt(),
                                            ),
                                          );
                                        } catch (_) {}
                                      },
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formatTimer(
                                              onPositionChanged.data!,
                                            ),
                                            style: AppTextStyleTheme.subTitle,
                                          ),
                                          Text(
                                            formatTimer(
                                              onDurationChanged.data!,
                                            ),
                                            style: AppTextStyleTheme.subTitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
