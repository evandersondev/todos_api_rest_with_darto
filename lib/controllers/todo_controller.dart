import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/services/todo_service.dart';

import '../models/todo_model.dart';

class TodoController {
  final TodoService _service;

  TodoController(this._service);

  void getAll(Request req, Response res) async {
    final todos = await _service.getTodos();

    return res.status(OK).json(todos);
  }

  Future<void> create(Request req, Response res) async {
    final todo = req.context['validateBody'];
    await _service.createTodo(TodoModel.fromJson(todo));

    return res.status(CREATED).end();
  }

  void update(Request req, Response res) async {
    final id = req.context['validateParam']['id'];
    final body = req.context['validateBody'];

    final todo = await _service.updateTodo(
      TodoModel.fromJson({...body, 'id': id}),
    );

    return res.status(OK).json(todo);
  }

  void delete(Request req, Response res) async {
    final id = req.context['validateParam']['id'];

    await _service.deleteTodo(id);
    return res.status(204).end();
  }
}
