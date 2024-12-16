import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:task_buddy/controllers/todo_controller.dart';
import 'package:task_buddy/widgets/reusable_widgets.dart';
import '../utility/values/colors.dart';
import '../utility/values/strings.dart';
import '../widgets/task_tile.dart';

class TodoPage extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:greyColor,
        appBar: AppBar(
          title: const Text(appName),
          backgroundColor: greyColor,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: tab1Name),
              Tab(text: tab2Name),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FloatingActionButton(
                onPressed: () {
                  showTaskDialog(context: context, controller: todoController);
                },
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              ),

              const Gap(16),
              // Tab Views for Completed and Uncompleted Tasks
              Expanded(
                child: TabBarView(
                  children: [
                    // Uncompleted Tasks
                    Obx(() {
                      var uncompletedTasks = todoController.tasks
                          .where((task) => !task.completed)
                          .toList();

                      return ListView.builder(
                        itemCount: uncompletedTasks.length,
                        itemBuilder: (context, index) {
                          final task = uncompletedTasks[index];
                          final originalIndex =
                              todoController.tasks.indexOf(task);
                          return TaskTile(
                            task: task,
                            onToggle: () {
                              todoController.toggleTask(originalIndex);

                              getSnackbar(
                                "Task",
                                "Task completed",
                               greenColor
                              );
                            },

                            onDelete: () {
                              todoController.deleteTask(originalIndex);

                              getSnackbar(
                                "Task",
                                "Task deleted",
                                orangeAccentColor
                              );
                            },
                            onEdit: () => showTaskDialog(
                                taskIndex: originalIndex,
                                context: context,
                                controller: todoController),
                            
                          );
                        },
                      );
                    }),
                    // Completed Tasks
                    Obx(() {
                      var completedTasks = todoController.tasks
                          .where((task) => task.completed)
                          .toList();

                      return ListView.builder(
                        itemCount: completedTasks.length,
                        itemBuilder: (context, index) {
                          final task = completedTasks[index];
                          final originalIndex =
                              todoController.tasks.indexOf(task);
                          return TaskTile(
                            task: task,
                            onToggle: () {
                              todoController.toggleTask(originalIndex);

                              getSnackbar(
                                "Task",
                                "Task added",
                                greenColor
                              );
                            },
                            onDelete: () {
                              todoController.deleteTask(originalIndex);

                              getSnackbar(
                                "Task",
                                "Task deleted",
                                orangeAccentColor
                              );
                            },
                            onEdit: () => showTaskDialog(
                                taskIndex: originalIndex,
                                context: context,
                                controller: todoController),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
