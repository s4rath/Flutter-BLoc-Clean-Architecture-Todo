// todo_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo.dart';
import '../cubit/todo_cubit.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (_) => context.read<TodoCubit>().toggleTodoStatus(todo.id),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.isCompleted 
            ? TextDecoration.lineThrough 
            : null,
        ),
      ),
      subtitle: Text(todo.description),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => context.read<TodoCubit>().removeTodo(todo.id),
      ),
    );
  }
}