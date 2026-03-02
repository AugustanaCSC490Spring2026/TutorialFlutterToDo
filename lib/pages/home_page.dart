import 'package:flutter/material.dart';
import 'package:tutorial_flutter_todo/utils/todo_list.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List toDoList = [
    ['Learn Flutter', false],
    ['Buy Matcha', false],
    ['Slay Dragon', false],
  ];

  void checkBoxChanged(int index){
    setState((){
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      appBar: AppBar (
        title: Text(
          "My To-Do List"
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: toDoList.length, 
        itemBuilder: (BuildContext context, index){
        return TodoList(
          taskName: toDoList[index][0],
          taskCompleted: toDoList[index][1],
          onChanged: (value) => checkBoxChanged(index),
          deleteFunction: (context) => deleteTask(index),
        );
      }),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'New To-Do Item',
                  filled: true,
                  fillColor: Colors.teal.shade400,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal.shade800,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal.shade300,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            ),
          FloatingActionButton(
            onPressed:saveNewTask,
            child: Icon(Icons.add),
            backgroundColor: Colors.teal,
            hoverColor: Colors.tealAccent.shade700,
            foregroundColor: Colors.white,
             ),
        ],
      ),
    );
  }
}