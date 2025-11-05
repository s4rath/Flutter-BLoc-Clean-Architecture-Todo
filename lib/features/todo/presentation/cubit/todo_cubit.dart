import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/todo_use_case.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final GetTodos getTodos;
  final CreateTodo createTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoCubit({
     required this.getTodos,
    required this.createTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial());

  void loadTodos() async {
    emit(TodoLoading());
    try {
      final todos = await getTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void addTodo(String title, String description) async {
    try {
      await createTodo(title, description);
      loadTodos();
      emit(TodoOperationSuccess('Todo created successfully'));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void editTodo(Todo todo) async {
    try {
      await updateTodo(todo);
      loadTodos();
      emit(TodoOperationSuccess('Todo edited successfully'));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void removeTodo(String id) async {
    try {
      await deleteTodo(id);
      loadTodos();
      emit(TodoOperationSuccess('Todo deleted'));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void toggleTodoStatus(String id) async {
    if (state is! TodoLoaded) return;

    final current = (state as TodoLoaded).todos;
    final index = current.indexWhere((i) => i.id == id);
    if (index == -1) return;
    final updatedTodo = Todo(
      id: current[index].id,
      description: current[index].description,
      title: current[index].title,
      isCompleted: !current[index].isCompleted,
    );

    try {
      await updateTodo(updatedTodo);
      loadTodos();
    } catch (e) {
      emit(TodoError('Failed to toggle status: $e'));
    }
  }
}
