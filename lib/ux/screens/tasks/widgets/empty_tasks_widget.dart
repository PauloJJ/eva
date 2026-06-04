import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/screens/tasks/widgets/add_task_widget.dart';
import 'package:flutter/material.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            '📆',
            style: TextStyle(fontSize: 150),
          ),

          Text(
            'Você ainda não possui nenhuma tarefa ativa',
            style: AppTextStyleTheme.h2,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 5),

          Text(
            'Cadastre suas tarefas diárias e deixe a Eva ajudar você a se organizar todos os dias.',
            style: AppTextStyleTheme.subTitle,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 30),

          ButtonsComponent.buttonFilled(
            title: 'Começar',
            function: () {
              AddTaskWidget().addTask();
            },
          ),
        ],
      ),
    );
  }
}
