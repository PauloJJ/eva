import 'package:eva/models/task_model.dart';
import 'package:eva/services/notification_local_service.dart';
import 'package:eva/services/task_service.dart';
import 'package:eva/ux/components/banner_quizz_component.dart';
import 'package:eva/ux/components/request_permission_notification.dart';
import 'package:eva/ux/screens/tasks/widgets/add_task_widget.dart';
import 'package:eva/ux/screens/tasks/widgets/empty_tasks_widget.dart';
import 'package:eva/ux/screens/tasks/widgets/list_tasks_widget.dart';
import 'package:eva/ux/screens/tasks/widgets/select_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});

  final TaskService taskService = Get.find<TaskService>();

  final NotificationLocalService notificationLocalService =
      Get.find<NotificationLocalService>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<TaskModel> listTasks = taskService.listTasks.value;

      final permissionNotification =
          notificationLocalService.permissionNotification.value!;

      if (permissionNotification.isDenied ||
          permissionNotification.isPermanentlyDenied ||
          permissionNotification.isRestricted) {
        return Scaffold(
          body: SafeArea(
            child: RequestPermissionNotification(),
          ),
        );
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(800),
            borderSide: BorderSide.none,
          ),
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            AddTaskWidget().addTask();
          },
        ),
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
