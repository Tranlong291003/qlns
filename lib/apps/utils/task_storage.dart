import 'package:qlns/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskStorage {
  static const String _key = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList = tasks.map((task) => task.toString()).toList();
    await prefs.setStringList(_key, taskList);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskList = prefs.getStringList(_key) ?? [];
    return taskList.map((taskStr) => Task.fromString(taskStr)).toList();
  }
}
