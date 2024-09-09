import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Todo(),
  ));
}

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> _todos = [];
  TextEditingController _textController = TextEditingController();

  void _addTodo() {
    String task = _textController.text;
    if (task.isNotEmpty) {
      setState(() {
        _todos.add({'task': task, 'isDone': false});
      });
      _textController.clear();
    }
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index]['isDone'] = !_todos[index]['isDone'];
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple To-Do App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter a task',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: _todos[index]['isDone'],
                    onChanged: (value) {
                      _toggleTodoStatus(index);
                    },
                  ),
                  title: Text(
                    _todos[index]['task'],
                    style: TextStyle(
                      decoration: _todos[index]['isDone']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
