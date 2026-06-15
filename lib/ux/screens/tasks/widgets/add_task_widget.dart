import 'dart:math';
import 'package:emojis/emoji.dart';
import 'package:eva/models/task_moc_model.dart';
import 'package:eva/services/add_task_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTaskWidget {
  AddTaskService addTaskService = Get.put(AddTaskService());
  List<Map<String, dynamic>> get listTasks => addTaskService.listTasks;

  int colorCard() {
    int random = Random().nextInt(addTaskService.listColor.length);

    return random;
  }

  addTask() {
    return showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return Obx(() {
          final PhasesTask phase = addTaskService.phase.value;

          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              Get.delete<AddTaskService>();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: addTaskService.colorIndex.value != null
                    ? addTaskService.listColor[addTaskService.colorIndex.value!]
                    : Colors.white,
              ),
              width: size.width,
              height: size.height / 1.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),

                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(800),
                          color: Colors.grey,
                        ),
                        width: 50,
                        height: 5,
                      ),
                    ),

                    SizedBox(height: 30),

                    if (phase == PhasesTask.phase01) phase01(),

                    if (phase == PhasesTask.phase02) phase02(),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget phase01() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    addTaskService.taskMocModel.value = TaskMocModel(
                      nameTask: '',
                      emoji: '❓',
                      repeat: [
                        'sunday',
                        'monday',
                        'tuesday',
                        'wednesday',
                        'thursday',
                        'friday',
                        'saturday',
                      ],
                      anytime: true,
                    );
                    addTaskService.colorIndex.value = 0;

                    addTaskService.phase.value = PhasesTask.phase02;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nova Tarefa',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        'Toque para Renomear',
                        style: AppTextStyleTheme.subTitle.apply(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listTasks.length,
              itemBuilder: (context, index) {
                TaskMocModel taskMocModel = TaskMocModel.fromJson(
                  listTasks[index],
                );

                int cardColor = colorCard();

                return InkWell(
                  onTap: () {
                    addTaskService.selectedTaskPhase01(
                      task: taskMocModel,
                      cardColor: cardColor,
                    );
                  },
                  child:
                      Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        elevation: 0,
                        color: addTaskService.listColor[cardColor],
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
                                  taskMocModel.nameTask,
                                  style: AppTextStyleTheme.title,
                                ),
                                subtitle: Text(
                                  addTaskService.timer.value == null
                                      ? 'A Qualquer momento'
                                      : 'Receber notificações em horários específicos',
                                ),
                                leading: Text(
                                  taskMocModel.emoji,
                                  style: TextStyle(fontSize: 25),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget phase02() {
    TaskMocModel taskMocModel = addTaskService.taskMocModel.value!;

    return Obx(
      () {
        bool isLoading = addTaskService.isLoading.value;

        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showEmojis();
                  },
                  child: Text(
                    taskMocModel.emoji,
                    style: TextStyle(fontSize: 100),
                  ),
                ),

                SizedBox(height: 5),

                TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: taskMocModel.nameTask,
                    hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                  onChanged: (value) {
                    addTaskService.taskMocModel.value!.nameTask = value;
                    addTaskService.taskMocModel.update((val) {});
                  },
                ),

                SizedBox(height: 20),

                Text(
                  'Toque para renomear',
                  style: AppTextStyleTheme.subTitle,
                ),

                SizedBox(height: 20),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: addTaskService.listColor.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () {
                            addTaskService.colorIndex.value = index;
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor: addTaskService.listColor[index],
                              child: addTaskService.colorIndex.value == index
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                InkWell(
                  onTap: () {
                    showOptionsRepetition();
                  },
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Repetir',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          text: addTaskService.selectedDays.value.length >= 7
                              ? 'Todos os dias  '
                              : 'Alguns dias  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                InkWell(
                  onTap: () {
                    showTimers();
                  },
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        Icons.timer_outlined,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Tempo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          text: addTaskService.timer.value == null
                              ? 'A qualquer momento  '
                              : '${DateFormat('HH:mm').format(addTaskService.timer.value!)}  ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                isLoading == true
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : FilledButton.icon(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          addTaskService.addTask();
                        },
                        label: SizedBox(
                          height: 55,
                          child: Center(
                            child: Text(
                              'Adicionar Tarefa',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  showEmojis() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: Get.context!,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 25),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(800),
                    color: Colors.grey,
                  ),
                  width: 50,
                  height: 5,
                ),
              ),

              SizedBox(height: 30),

              Text(
                'Escolha um emoji para representar sua tarefa',
                textAlign: TextAlign.center,
                style: AppTextStyleTheme.subTitle,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  shrinkWrap: false,
                  itemCount: Emoji.all().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        addTaskService.taskMocModel.value!.emoji =
                            Emoji.all()[index].char;

                        addTaskService.taskMocModel.update((val) {});

                        Get.back();
                      },
                      child: Center(
                        child: Text(
                          Emoji.all()[index].char,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showOptionsRepetition() {
    List<String> days = addTaskService.daysOfTheWeek;

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          width: size.width,
          height: size.height / 1.2,
          child: Column(
            children: [
              SizedBox(height: 25),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(800),
                    color: Colors.grey,
                  ),
                  width: 50,
                  height: 5,
                ),
              ),

              SizedBox(height: 40),

              Text(
                'Configuração de repetição',
                style: AppTextStyleTheme.title,
              ),

              SizedBox(height: 20),

              SizedBox(
                height: 55,
                child: ListView.builder(
                  itemCount: days.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    return Obx(
                      () {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ChoiceChip(
                            onSelected: (value) {
                              addTaskService.selectedAndRemoveDay(
                                day: days[index],
                                index: index,
                              );
                            },
                            checkmarkColor: Colors.black,
                            selectedColor: color.secondary,
                            selected: addTaskService.selectedDays.value
                                .contains(
                                  days[index],
                                ),
                            label: Text(
                              days[index].replaceRange(3, null, ''),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonsComponent.buttonFilled(
                  isLoading: addTaskService.isLoading.value,
                  title: 'Concluir',
                  function: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showTimers() {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) {
        return Obx(
          () {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              height: size.height / 1.2,
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 25),

                      Row(
                        spacing: 5,
                        children: [
                          CloseButton(
                            onPressed: () {
                              Get.back();
                            },
                          ),

                          Text(
                            'Configurar Horário',
                            style: AppTextStyleTheme.title,
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      ChoiceChip(
                        onSelected: (value) {
                          addTaskService.timer.value = null;
                        },
                        checkmarkColor: Colors.black,
                        selectedColor: color.secondary,
                        selected: addTaskService.timer.value == null
                            ? true
                            : false,
                        label: SizedBox(
                          width: size.width,
                          child: Text(
                            'A qualquer momento',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Divider(height: 40),

                      Expanded(
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: true,
                          onDateTimeChanged: (value) {
                            addTaskService.timer.value = value;
                          },
                        ),
                      ),

                      ButtonsComponent.buttonFilled(
                        title: 'Concluir',
                        function: () {
                          Get.back();
                        },
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
