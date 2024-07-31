// lib/src/task_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String name;

  Task({required this.name});
}

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _completedTasks = []; // Separate list for completed tasks

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _completedTasks;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    final completedTasks = prefs.getStringList('completedTasks') ?? [];
    _tasks = tasks.map((task) => Task(name: task)).toList();
    _completedTasks = completedTasks.map((task) => Task(name: task)).toList();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskNames = _tasks.map((task) => task.name).toList();
    final completedTaskNames = _completedTasks.map((task) => task.name).toList();
    await prefs.setStringList('tasks', taskNames);
    await prefs.setStringList('completedTasks', completedTaskNames);
  }

  void addTask(String taskName) {
    final newTask = Task(name: taskName);
    _tasks.add(newTask);
    _saveTasks();
    notifyListeners();
    if (_completedTasks.length== 51) {
    _tasks.clear();
    _completedTasks.clear();
    _tasks.add(newTask);
  }
  }

  void completeTask(int index) {
    final task = _tasks.removeAt(index);
    _completedTasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void resetTasks() {
    _tasks.clear();
    _completedTasks.clear();
    _saveTasks();
    notifyListeners();
  }
}
