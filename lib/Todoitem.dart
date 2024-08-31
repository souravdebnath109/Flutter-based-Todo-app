import 'package:flutter/material.dart';
import 'Insidetodo.dart';

class Todoitem extends StatelessWidget {
  final Insidetodo todo;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onEdit; // Added onEdit callback
  final VoidCallback onDelete;

  const Todoitem({
    Key? key,
    required this.todo,
    required this.onChanged,
    required this.onEdit, // Added onEdit callback
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.todotext,
        style: TextStyle(
          color: Colors.white,
          decoration: todo.isdone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white), // Edit icon
            onPressed: onEdit, // Trigger edit callback
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
      leading: Checkbox(
        value: todo.isdone,
        onChanged: onChanged,
      ),
    );
  }
}
