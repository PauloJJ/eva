import 'package:eva/ux/screens/tasks/widgets/select_date_widget.dart';
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SelectDateWidget(),
          ],
        ),
      ),
    );
  }
}
