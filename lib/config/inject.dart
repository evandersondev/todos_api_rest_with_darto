import 'package:injectfy/injectfy.dart';
import 'package:todos_api_rest_with_darto/controllers/todo_controller.dart';
import 'package:todos_api_rest_with_darto/services/todo_service.dart';

import '../repositories/remote/todo_repository_impl.dart';
import '../repositories/todo_repository.dart';

class Inject {
  static init() {
    final injectfy = Injectfy.I;

    injectfy.registerSingleton<TodoRepository>(() => TodoRepositoryImpl());
    injectfy.registerSingleton<TodoService>(() => TodoService(injectfy()));
    injectfy.registerFactory<TodoController>(() => TodoController(injectfy()));
  }
}
