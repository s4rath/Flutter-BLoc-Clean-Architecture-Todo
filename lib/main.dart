import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/core/network/dio_client.dart';
import 'features/todo/data/datasources/todo_data_source.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/usecases/todo_use_case.dart';
import 'features/todo/presentation/cubit/todo_cubit.dart';
import 'features/todo/presentation/pages/todo_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Dio dio = DioClient().dio;

  final remoteDataSource = TodoRemoteDataSource(dio);

  final repository = TodoRepositoryImpl(remoteDataSource);

  final getTodos = GetTodos(repository);
  final createTodo = CreateTodo(repository);
  final updateTodo = UpdateTodo(repository);
  final deleteTodo = DeleteTodo(repository);

  runApp(
    MyApp(
      getTodos: getTodos,
      createTodo: createTodo,
      updateTodo: updateTodo,
      deleteTodo: deleteTodo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetTodos getTodos;
  final CreateTodo createTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;
  const MyApp({
    super.key,
    required this.getTodos,
    required this.createTodo,
    required this.updateTodo,
    required this.deleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => TodoCubit(
                getTodos: getTodos,
                createTodo: createTodo,
                updateTodo: updateTodo,
                deleteTodo: deleteTodo,
              )..loadTodos(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: TodoListPage(),
      ),
    );
  }
}
