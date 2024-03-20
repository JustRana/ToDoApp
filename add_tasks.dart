import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/pages/TaskPage.dart';

class AddTask extends StatefulWidget {
  final Function addTaskCallback;

  AddTask(this.addTaskCallback);

  @override
  _AddTaskState createState() => _AddTaskState();

  
}

class _AddTaskState extends State<AddTask> {
  String newTaskTitle = '';
  IconData? selectedIcon;
  Color? selectedColor;
  

  List<IconData> icons = [
    Icons.favorite,
    Icons.star,
    Icons.shopping_cart,
    Icons.self_improvement,
    Icons.restaurant,
    Icons.menu_book,
    
    
  ];

  List<Color> colors = [
    Color.fromARGB(255, 116, 30, 125),
    Color.fromARGB(255, 99, 187, 102),
    Color.fromARGB(255, 238, 140, 216),
    Color.fromARGB(255, 14, 171, 233),
    Color.fromARGB(255, 5, 6, 6),
    Color.fromARGB(255, 180, 63, 63),
    
  
  ];

  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'Add Your Task',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              setState(() {
                newTaskTitle = newText;
              });
            },
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Icon:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<IconData>(
                value: selectedIcon,
                onChanged: (IconData? newValue) {
                  setState(() {
                    selectedIcon = newValue;
                  });
                },
                items: icons.map<DropdownMenuItem<IconData>>((IconData value) {
                  return DropdownMenuItem<IconData>(
                    value: value,
                    child: Icon(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Color:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<Color>(
                value: selectedColor,
                onChanged: (Color? newValue) {
                  setState(() {
                    selectedColor = newValue;
                  });
                },
                items: colors.map<DropdownMenuItem<Color>>((Color value) {
                  return DropdownMenuItem<Color>(
                    value: value,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: value,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 25),
          TextButton(
            onPressed: () {
              if (newTaskTitle.isEmpty ||
                  (selectedIcon != null &&
                  selectedColor != null)) {
                    
                Provider.of<TaskData>(context, listen: false).addTask(
                  newTaskTitle,
                  selectedIcon??icons[0],
                  selectedColor??colors[0],
                );
                Navigator.pop(context);
                
              }
            },
            child: Text('Add'),
            style: TextButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 3, 65, 96),
              primary: const Color.fromARGB(255, 238, 237, 237),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final void Function(bool?) checkboxChange;
  final bool isChecked;
  final String taskTitle;
  final IconData taskIcon;
  final Color taskColor;
  final void Function() listTileDelete;

  TaskTile({
    required this.isChecked,
    required this.taskTitle,
    required this.taskIcon,
    required this.taskColor,
    required this.checkboxChange,
    required this.listTileDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        taskIcon,
        color: taskColor,
      ),
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: const Color.fromARGB(255, 3, 65, 96),
        value: isChecked,
      
        onChanged: checkboxChange,
      ),
      onLongPress: listTileDelete,
    );
  }
}