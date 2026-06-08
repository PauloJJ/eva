import 'package:eva/models/task_model.dart';
import 'package:eva/services/task_service.dart';
import 'package:eva/ux/components/banner_quizz_component.dart';
import 'package:eva/ux/screens/tasks/widgets/empty_tasks_widget.dart';
import 'package:eva/ux/screens/tasks/widgets/list_tasks_widget.dart';
import 'package:eva/ux/screens/tasks/widgets/select_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  final TaskService taskService = Get.find<TaskService>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<TaskModel> listTasks = taskService.listTasks.value;

      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SelectDateWidget(),

              if (listTasks.isEmpty) EmptyTasksWidget(),

              if (listTasks.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 10),

                          BannerQuizzComponent(),

                          SizedBox(height: 10),

                          ListTasksWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
