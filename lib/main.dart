import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App Tutorial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'To-Do List Home Page'),
      
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  var toDoList = <TodoItem>[
    TodoItem(
    title: "Buy groceries",
    dueAt: DateTime(2026, 3, 1),
  ),
  TodoItem(
    title: "Finish project",
    dueAt: DateTime(2026, 3, 5),
  ),
  TodoItem(
    title: "Gym session",
    dueAt: DateTime(2026, 2, 28),
  ),
  ];


  @override
  void initState() {
    super.initState();
    toDoList.sort((a, b) => a.dueAt.compareTo(b.dueAt));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Todo Application",
        ),
      ),

      body: ListView(
        children: [
          for (var item in toDoList)
            ListTile(
              title: Text(
                item.title, 
                textAlign: TextAlign.center,
                ),
              subtitle: Text(
                "Due: ${item.dueAt.month}/${item.dueAt.day}/${item.dueAt.year}",
                textAlign: TextAlign.center, 
                ),
            ),

          
        ],
      ),

      backgroundColor: Colors.indigo,
    );
  
  }
}


class TodoItem{
  final String title;
  final DateTime dueAt;

  TodoItem({required this.title, required this.dueAt});
}