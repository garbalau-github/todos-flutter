import 'package:flutter/material.dart';
import 'package:flutter_todos/components/dialog_box.dart';
import 'package:flutter_todos/components/todo_tile.dart';
import 'package:flutter_todos/database/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Get the Hive box
  final box = Hive.box('todoBox');
  TodoDatabase todoDatabase = TodoDatabase();

  // Is this lifecycle method the best place to load the data?
  @override
  void initState() {
    super.initState();
    if (box.get('todoList') == null) {
      todoDatabase.createInitialData();
    } else {
      todoDatabase.loadData();
    }
  }

  final _controller = TextEditingController();

  void checkBoxChanged(int index) {
    setState(() {
      todoDatabase.todoList[index][1] = !todoDatabase.todoList[index][1];
    });
    todoDatabase.updateDataBase();
  }

  void onCancelDialog() {
    _controller.clear();
    Navigator.of(context).pop();
  }

  void onSaveDialog() {
    if (_controller.text.isEmpty) {
      return;
    }
    setState(() {
      todoDatabase.todoList.add([_controller.text, false]);
    });
    todoDatabase.updateDataBase();

    _controller.clear();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: onSaveDialog,
            onCancel: onCancelDialog,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      todoDatabase.todoList.removeAt(index);
    });
    todoDatabase.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Flutter Todos'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoDatabase.todoList.length,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: TodoTile(
              taskName: todoDatabase.todoList[index][0],
              taskCompleted: todoDatabase.todoList[index][1],
              onChanged: (bool? value) => checkBoxChanged(index),
              deleteTask: (BuildContext? context) => deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}
