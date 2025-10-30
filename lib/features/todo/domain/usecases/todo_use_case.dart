import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;
  GetTodos(this.repository);
  Future<List<Todo>> call() => repository.getTodos();
}

class CreateTodo {
  final TodoRepository repository;
  CreateTodo(this.repository);
  Future<Todo> call(String title, String description) =>
      repository.createTodo(title, description);
}

class UpdateTodo {
  final TodoRepository repository;
  UpdateTodo(this.repository);
  Future<Todo> call(Todo todo) => repository.updateTodo(todo);
}

class DeleteTodo {
  final TodoRepository repository;
  DeleteTodo(this.repository);
  Future<void> call(String id) => repository.deleteTodo(id);
}


