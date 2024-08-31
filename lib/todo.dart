import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Insidetodo.dart';
import 'Todoitem.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Insidetodo> todoslist = [];
  final TextEditingController _controller = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Load tasks when the widget is first created
  }

  void _loadTodos() async {
    if (_userId != null) {
      // Fetch the tasks from Firebase under the user's ID
      _database.child('users/$_userId/todos').onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null) {
          // Convert the data to a map and then to a list of tasks
          final Map<dynamic, dynamic> todosMap = data as Map<dynamic, dynamic>;
          List<Insidetodo> loadedTodos = [];
          todosMap.forEach((key, value) {
            loadedTodos.add(Insidetodo.fromJson(Map<String, dynamic>.from(value)));
          });
          setState(() {
            todoslist = loadedTodos; // Update the UI with the loaded tasks
          });
        }
      });
    }
  }

  void _saveTodoToFirebase(Insidetodo todo) {
    if (_userId != null) {
      _database.child('users/$_userId/todos').child(todo.id).set(todo.toJson());
    }
  }

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final newTodo = Insidetodo(
        id: DateTime.now().toString(),
        todotext: text,
        isdone: false,
      );

      setState(() {
        todoslist.add(newTodo);
        _controller.clear();
      });
      _saveTodoToFirebase(newTodo); // Save the new task to Firebase without overriding
    }
  }

  void _editTodo(Insidetodo todo) async {
    final TextEditingController _editController = TextEditingController(text: todo.todotext);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(
              hintText: 'Edit your task',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedText = _editController.text.trim();
                if (updatedText.isNotEmpty) {
                  setState(() {
                    todo.todotext = updatedText;
                  });
                  _saveTodoToFirebase(todo); // Save the updated task to Firebase
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodo(Insidetodo todo) async {
    if (_userId != null) {
      // Remove the item from Firebase
      await _database.child('users/$_userId/todos').orderByChild('id').equalTo(todo.id).once().then((snapshot) {
        if (snapshot.snapshot.value != null) {
          Map<dynamic, dynamic> map = snapshot.snapshot.value as Map<dynamic, dynamic>;
          map.forEach((key, value) async {
            await _database.child('users/$_userId/todos').child(key).remove();
          });
        }
      });
      setState(() {
        todoslist.remove(todo); // Update the UI after deletion
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 64, 64, 1),
        title: const Text('To-Do List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromRGBO(32, 32, 32, 1), // Background color for the entire body
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                          child: const Text(
                            'ALL TASKS:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        for (var todo in todoslist)
                          Todoitem(
                            todo: todo,
                            onChanged: (isDone) {
                              setState(() {
                                todo.isdone = isDone ?? false;
                              });
                              _saveTodoToFirebase(todo); // Save the updated task status to Firebase
                            },
                            onEdit: () => _editTodo(todo),
                            onDelete: () => _deleteTodo(todo),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                        right: 10.0,
                        left: 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.grey,
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          hintText: 'Add your text here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(33, 22, 22, 0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _addTodo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
