// Edit Task Dialog
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:task_buddy/controllers/todo_controller.dart';
import 'package:task_buddy/utility/values/colors.dart';

void showTaskDialog({
  required BuildContext context,
  required TodoController controller,
  int? taskIndex,
}) {
  final isEditing = taskIndex != null;
  final task = isEditing ? controller.tasks[taskIndex] : null;
  final titleController = TextEditingController(text: task?.title ?? '');
  final descriptionController =
      TextEditingController(text: task?.description ?? '');

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String newTitle = titleController.text.trim();
              String newDescription = descriptionController.text.trim();
              if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
                if (isEditing) {
                  // Update task if editing
                  controller.updateTask(taskIndex, newTitle, newDescription);

                  getSnackbar(
                    "Success",
                    "Task updated",
                    blueColor
                  );
                } else {
                  // Add new task
                  controller.addTask(newTitle, newDescription);

                  getSnackbar(
                    "Success",
                    "New Task added",
                    blueColor
                  );
                }
                Navigator.of(context).pop();
              } else {
                getSnackbar(
                  "Error",
                  "Title and Description cannot be empty",
                  redAccentColor
                );
              }
            },
            child: Text(isEditing ? 'Save' : 'Add'),
          ),
        ],
      );
    },
  );
}

void getSnackbar(String title, String details, Color color) {
  Get.snackbar(
    title,
    details,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    colorText: whiteColor
  );
}
