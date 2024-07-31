import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_provider.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  _TasksViewState createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  Future<void> _showAddTaskDialog(BuildContext context) async {
    String newTask = '';

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          title: Text(
            'Add Task',
            style: TextStyle(
              color: isDarkMode ? Colors.greenAccent : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            onChanged: (String value) {
              newTask = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter task name',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  Navigator.pop(context, newTask);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Task name cannot be empty!'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          elevation: 4.0,
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        Provider.of<TaskProvider>(context, listen: false).addTask(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/logov2.png',
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                        value: false,
                        onChanged: (value) {
                          if (value == true) {
                            taskProvider.completeTask(index);
                          }
                        },
                      ),
                      title: Text(taskProvider.tasks[index].name),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Add Task',
        child: Icon(Icons.add),
        backgroundColor: isDarkMode ? Color.fromARGB(255, 20, 103, 39) : Colors.green,
        foregroundColor: Colors.white,
        elevation: 2.0,
        shape: CircleBorder(
          side: BorderSide(
            color: isDarkMode ? Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0),
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
