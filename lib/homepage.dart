import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final toDoList = <TodoItem>[
    TodoItem(title: "Buy groceries", dueAt: DateTime(2026, 3, 1)),
    TodoItem(title: "Finish project", dueAt: DateTime(2026, 3, 5)),
    TodoItem(title: "Gym session", dueAt: DateTime(2026, 2, 28)),
  ];

  @override
  void initState() {
    super.initState();
    _sortTodos();
  }

  void _sortTodos() {
    toDoList.sort((a, b) => a.dueAt.compareTo(b.dueAt));
  }

  String _formatDate(DateTime d) => "${d.month}/${d.day}/${d.year}";

  void _showAddTodoDialog() {
    final titleController = TextEditingController();
    DateTime? pickedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Task title"),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    pickedDate = date;
                  }
                },
                child: const Text("Pick due date"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final due = pickedDate ?? DateTime.now();

                if (title.isEmpty) return;

                setState(() {
                  toDoList.add(TodoItem(title: title, dueAt: due));
                  _sortTodos();
                });

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Todo Application"),
      ),

      body: ListView(
        children: [
          for (var i = 0; i < toDoList.length; i++)
            Dismissible(
              key: ValueKey(
                "${toDoList[i].title}-${toDoList[i].dueAt.toIso8601String()}",
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                setState(() {
                  toDoList.removeAt(i);
                });
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: CheckboxListTile(
                value: toDoList[i].isDone,
                onChanged: (val) {
                  setState(() {
                    toDoList[i].isDone = val ?? false;
                  });
                },
                title: Text(
                  toDoList[i].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration:
                        toDoList[i].isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(
                  "Due: ${_formatDate(toDoList[i].dueAt)}",
                  textAlign: TextAlign.center,
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),

      backgroundColor: const Color.fromARGB(255, 211, 145, 21),
    );
  }
}

class TodoItem {
  final String title;
  final DateTime dueAt;
  bool isDone;

  TodoItem({
    required this.title,
    required this.dueAt,
    this.isDone = false,
  });
}