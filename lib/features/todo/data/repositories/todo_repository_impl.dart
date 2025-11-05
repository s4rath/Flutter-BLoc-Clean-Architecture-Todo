import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl(this.remoteDataSource);
  // final TodoLocalDataSource localDataSource;

  @override
  Future<List<Todo>> getTodos() async {
    try {
      final todos = await remoteDataSource.getTodos();
      // Cache them locally
      // await localDataSource.cacheTodos(todos);
      return todos.map((todo) => todo as Todo).toList();
    } catch (e) {
      // If API fails, get from cache
      return [];
      // return await localDataSource.getCachedTodos();
    }
  }

  @override
  Future<Todo> createTodo(String title, String description) {
    return remoteDataSource.createTodo(title, description);
  }

  @override
  Future<Todo> updateTodo(Todo todo) {
    final model = TodoModel(
      id: todo.id,
      description: todo.description,
      title: todo.title,
      isCompleted: todo.isCompleted,
    );
    return remoteDataSource.updateTodo(model);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await remoteDataSource.deleteTodo(id);
  }
}
