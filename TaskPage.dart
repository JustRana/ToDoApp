import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/pages/add_tasks.dart';

class Task {
  final String name;
  final IconData icon;
  final Color color;
  bool isDone;

  Task({
    required this.name,
    required this.icon,
    required this.color,
    this.isDone = false,
  });

  void doneChanged() {
    isDone = !isDone;
  }
}

class TaskData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String newTaskTitle, IconData selectedIcon, Color selectedColor) {
    tasks.add(Task(
      name: newTaskTitle,
      icon: selectedIcon,
      color: selectedColor,
    ));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.doneChanged();
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

}

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTask((newTaskTitle ,selectedIcon , selectedColor) {
                      Provider.of<TaskData>(context , listen: false).addTask(newTaskTitle ,selectedIcon, selectedColor,);
                      Navigator.pop(context);
                  }),
              ),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 3, 65, 96),
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 201, 204, 205),
      body: Container(
        padding: const EdgeInsets.only(
            top: 60, left: 20, right: 20, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.playlist_add_check,
                    size: 52,
                    color: const Color.fromARGB(255, 2, 2, 2)),
                SizedBox(width: 22),
                Text(
                  'To Do',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'Tasks',
              style: TextStyle(
                color: Color.fromARGB(255, 45, 44, 44),
                fontSize: 16,
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 245, 246),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),

                  ),
                ),
                child: TasksList(),
   
                ),
              ),
          ],
        ),
      ),
    );
  }
  
}


class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
        itemCount: taskData.tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            taskTitle: taskData.tasks[index].name,
            taskIcon: taskData.tasks[index].icon,
            taskColor: taskData.tasks[index].color,
            isChecked: taskData.tasks[index].isDone,
            checkboxChange: (newValue) {
              taskData.updateTask(taskData.tasks[index]);
            },
            listTileDelete: () {
              taskData.deleteTask(taskData.tasks[index]);
            },
          );
        },
      );
    });
  }
}


