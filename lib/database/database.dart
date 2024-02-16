import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  final box = Hive.box('todoBox');

  // Initial data on first time ever opening the app
  void createInitialData() {
    todoList = [
      ['Learn Flutter', false],
      ['Make tutorial', false],
    ];
  }

  // Load data from the database (not first time)
  void loadData() {
    todoList = box.get('todoList', defaultValue: todoList);
  }

  // Update database
  void updateDataBase() {
    box.put('todoList', todoList);
  }
}
