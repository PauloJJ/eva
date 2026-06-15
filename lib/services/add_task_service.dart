import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/task_moc_model.dart';
import 'package:eva/models/task_model.dart';
import 'package:eva/services/task_service.dart';
import 'package:eva/utils/list_colors.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

enum PhasesTask { phase01, phase02 }

class AddTaskService extends GetxController {
  final List<String> daysOfTheWeek = [
    'Domingo',
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
  ];

  final Rx<List<String>> selectedDays = Rx([
    'Domingo',
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
  ]);

  Rx<DateTime?> timer = Rx(null);

  final listColor = ListColors.colors;

  List<Map<String, dynamic>> listTasks = [
    {
      'nameTask': 'Escovar os Dentes',
      'emoji': '🪥',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Lavar o Rosto',
      'emoji': '🧼',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Tomar Banho',
      'emoji': '🚿',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Arrumar a Cama',
      'emoji': '🛏️',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Tomar Água',
      'emoji': '💧',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Tomar Café da Manhã',
      'emoji': '☕',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Almoçar',
      'emoji': '🍽️',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Jantar',
      'emoji': '🍛',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Praticar Exercícios',
      'emoji': '🏃',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Alongar',
      'emoji': '🤸',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Estudar',
      'emoji': '📚',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Trabalhar',
      'emoji': '💼',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Lavar a Louça',
      'emoji': '🍽️',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Tirar o Lixo',
      'emoji': '🗑️',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Passear com o Cachorro',
      'emoji': '🐕',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Fazer Compras',
      'emoji': '🛒',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Pagar Contas',
      'emoji': '💰',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Ler um Livro',
      'emoji': '📖',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Meditar',
      'emoji': '🧘',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Dormir',
      'emoji': '😴',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Organizar a Casa',
      'emoji': '🏠',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Responder Mensagens',
      'emoji': '📱',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Regar as Plantas',
      'emoji': '🪴',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Lavar Roupas',
      'emoji': '👕',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Assistir TV',
      'emoji': '📺',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Ouvir Música',
      'emoji': '🎵',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Cortar as Unhas',
      'emoji': '💅',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Abrir as Janelas',
      'emoji': '🪟',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Verificar Humor',
      'emoji': '🙂',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
    {
      'nameTask': 'Conversar com a Família',
      'emoji': '👨‍👩‍👧‍👦',
      'repeat': [
        'sunday',
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
      ],
      'anytime': true,
      'schedules': [],
    },
  ];

  Rx<int?> colorIndex = Rx(null);
  Rx<TaskMocModel?> taskMocModel = Rx(null);

  Rx<PhasesTask> phase = Rx(PhasesTask.phase01);

  RxBool isLoading = false.obs;

  selectedTaskPhase01({required TaskMocModel task, required int cardColor}) {
    taskMocModel.value = task;
    colorIndex.value = cardColor;
    phase.value = PhasesTask.phase02;
  }

  selectedAndRemoveDay({required String day, required int index}) {
    if (selectedDays.value.length <= 1 && selectedDays.value.contains(day)) {
      return null;
    }

    if (selectedDays.value.contains(day)) {
      selectedDays.value.remove(day);
    } else {
      selectedDays.value.add(day);
    }

    selectedDays.update((val) {});
  }

  addTask() async {
    final TaskMocModel task = taskMocModel.value!;

    final TaskService taskService = Get.find<TaskService>();

    if (task.nameTask.isEmpty) {
      return FeedbackComponent.definitiveError(
        message: 'Dê um nome à sua tarefa',
      );
    }

    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      isLoading.value = true;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc()
          .set(
            TaskModel(
              creationDate: DateTime.now(),
              emoji: task.emoji,
              indexColor: colorIndex.value!,
              nameTask: task.nameTask,
              repeat: selectedDays.value,
              schedules: timer.value,
              taskId: Random().nextInt(100000).toString(),
            ).toJson(),
          );

      await taskService.registerNotifications();

      Get.back();
    } catch (_) {
      return FeedbackComponent.definitiveError(
        message:
            'Ops! Algo deu errado. Tente novamente em instantes. Se o erro continuar, fale conosco pela página do aplicativo na loja.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
