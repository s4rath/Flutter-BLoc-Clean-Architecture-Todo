import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../cubit/todo_cubit.dart';

class AddEditTodoDialog extends StatefulWidget {
  final Todo? todo;
  const AddEditTodoDialog({super.key, this.todo});

  @override
  State<AddEditTodoDialog> createState() => _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late bool isEditMode;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.todo != null;
    _titleController = TextEditingController(text: widget.todo?.title ?? "");
    _descController = TextEditingController(
      text: widget.todo?.description ?? "",
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _save() {
    final cubit = context.read<TodoCubit>();
    String title = _titleController.text.trim();
    String desc = _descController.text.trim();

    if (title.isEmpty) return;

    if (isEditMode) {
      cubit.updateTodo(
        Todo(
          id: widget.todo!.id,
          title: title,
          description: desc,
          isCompleted: widget.todo!.isCompleted,
        ),
      );
    } else{
      cubit.addTodo(title, desc);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditMode ? 'Edit Todo' : 'Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}
