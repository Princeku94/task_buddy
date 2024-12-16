import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/task.dart';

class TodoController extends GetxController {
  final _storage = GetStorage();
  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    List<dynamic>? savedTasks = _storage.read<List>('tasks');
    if (savedTasks != null) {
      tasks.addAll(savedTasks.map((e) => Task.fromJson(e)).toList());
    }
  }

  // Add a task
  void addTask(String title, String description) {
    if (title.isNotEmpty && description.isNotEmpty) {
      tasks.add(Task(title: title, description: description));
      _saveTasks();
    }
  }

  // Update an existing task
  void updateTask(int index, String newTitle, String newDescription) {
    if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
      tasks[index].title = newTitle;
      tasks[index].description = newDescription;
      tasks.refresh(); // Notify observers
      _saveTasks();
    }
  }

  // Toggle task completion
  void toggleTask(int index) {
    tasks[index].completed = !tasks[index].completed;
    tasks.refresh();
    _saveTasks();
  }

  // Delete a task
  void deleteTask(int index) {
    tasks.removeAt(index);
    _saveTasks();
  }

  // Save tasks to storage
  void _saveTasks() {
    _storage.write('tasks', tasks.map((task) => task.toJson()).toList());
  }
}
