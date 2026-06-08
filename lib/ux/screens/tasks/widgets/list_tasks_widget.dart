import 'package:eva/models/task_model.dart';
import 'package:eva/services/task_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/list_colors.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';

class ListTasksWidget extends StatelessWidget {
  ListTasksWidget({super.key});

  final TaskService taskService = Get.find<TaskService>();

  @override
  Widget build(BuildContext context) {
    List<TaskModel> listTasks = taskService.listTasks.value;

    return ListView.builder(
      itemCount: listTasks.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Obx(
          () {
            TaskModel taskModel = listTasks[index];

            String dateSelect = DateFormat(
              'dd/MM/yyyy',
            ).format(taskService.dateSelect.value);

            dateSelect = taskService.formatDateAndDocId(taskModel.docId!);

            bool taskCompleted = taskService.tasksCompleted.value.contains(
              dateSelect,
            );
            return InkWell(
              onLongPress: () {
                FeedbackComponent.showConfirmAction(
                  information:
                      'Ao excluir esta tarefa, ela deixará de aparecer na sua rotina. Continuar?',
                  function: () {
                    taskService.deleteTask(taskModel.docId!);
                  },
                );
              },
              onTap: () {
                taskService.taskCompletedOrRemove(
                  taskModel.docId!,
                );
              },
              child:
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    elevation: 0,
                    color: ListColors.colors[taskModel.indexColor],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            minVerticalPadding: 0,
                            title: Text(
                              taskModel.nameTask,
                              style: AppTextStyleTheme.title,
                            ),
                            subtitle: Text(
                              taskModel.schedules == null
                                  ? 'A Qualquer momento'
                                  : 'Receber notificações em horários específicos',
                            ),
                            leading: Text(
                              taskModel.emoji,
                              style: TextStyle(fontSize: 25),
                            ),

                            trailing: Transform.scale(
                              scale: 1.6,
                              child: Checkbox.adaptive(
                                value: taskCompleted,
                                onChanged: (value) {
                                  taskService.taskCompletedOrRemove(
                                    taskModel.docId!,
                                  );
                                },
                                shape: CircleBorder(),
                                side: BorderSide(
                                  width: 1.4,
                                  color: Colors.black.withAlpha(90),
                                ),
                                activeColor: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).paddingOnly(
                    bottom: listTasks.length == (index + 1) ? 20 : 0,
                  ),
            );
          },
        );
      },
    );
  }
}
