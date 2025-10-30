import 'package:dio/dio.dart';

import '../models/todo_model.dart';

class TodoRemoteDataSource {
  final Dio _dio;

  TodoRemoteDataSource(this._dio);
  
  Future<List<TodoModel>> getTodos() async {
    final response = await _dio.get('/todos');
    return (response.data as List)
        .map((json) => TodoModel.fromJson(json))
        .toList();
  }
  
  Future<TodoModel> createTodo(String title, String description) async {
    final response = await _dio.post('/todos', data: {
      'title': title,
      'description': description,
      'isCompleted': false,
    });
    return TodoModel.fromJson(response.data);
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    final response = await _dio.put('/todos/${todo.id}', data: todo.toJson());
    return TodoModel.fromJson(response.data);
  }

  Future<void> deleteTodo(String id) async {
    await _dio.delete('/todos/$id');
  }

}

