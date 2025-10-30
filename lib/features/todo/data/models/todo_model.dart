import 'package:todo_app_cubit/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description']?? '',
      isCompleted: json['isCompleted']?? false,
    );
  }

  Map<String,dynamic>toJson(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted
    };
  }
}
