import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';
import '../widget/add_edit_todo_dialog.dart';
import '../widget/todo_item.dart';



class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  void _showAddTodoDialog(BuildContext context, {Todo? todo}) {
  showDialog(
    context: context,
    builder: (_) => AddEditTodoDialog(todo: todo),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Todos')),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return GestureDetector(
                  onTap: ()=> _showAddTodoDialog(context, todo: todo),
                  child: TodoItem(todo: todo,),
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('No todos yet'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

