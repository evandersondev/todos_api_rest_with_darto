import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/services/todo_service.dart';
import 'package:zard/zard.dart';

import '../models/todo_model.dart';

final createTodoBodySchema = z.map({
  'title': z.string().min(3),
  'completed': z.bool().optional(),
});

final updateTodoBodySchema = z.map({
  'title': z.string().min(3).optional(),
  'completed': z.bool().optional(),
});

final idParamSchema = z.coerce.int();

class TodoController {
  final TodoService _service;

  TodoController(this._service);

  void getAll(Request req, Response res) async {
    final todos = await _service.getTodos();

    return res.status(200).json(todos);
  }

  Future<void> create(Request req, Response res) async {
    try {
      final todo = await createTodoBodySchema.parseAsync(req.body);
      await _service.createTodo(TodoModel.fromJson(todo!));

      return res.status(CREATED).end();
    } catch (e) {
      if (e is ZardError) {
        return res.status(NOT_ACCEPTABLE).json({'Errors': e.format()});
      }

      return res.status(INTERNAL_SERVER_ERROR).json({'Error': e.toString()});
    }
  }

  void update(Request req, Response res) async {
    try {
      final id = idParamSchema.parse(req.params['id']);
      final body = await updateTodoBodySchema.parseAsync(req.body);

      final todo = await _service.updateTodo(
        TodoModel.fromJson({...body!, 'id': id}),
      );

      return res.status(200).json(todo);
    } catch (e) {
      if (e is ZardError) {
        return res.status(NOT_ACCEPTABLE).json({'Errors': e.format()});
      }

      return res.status(INTERNAL_SERVER_ERROR).json({'Error': e.toString()});
    }
  }

  void delete(Request req, Response res) async {
    try {
      final id = idParamSchema.parse(req.params['id'] ?? '');

      await _service.deleteTodo(id);
      return res.status(204).end();
    } catch (e) {
      if (e is ZardError) {
        return res.status(NOT_ACCEPTABLE).json({'Errors': e.format()});
      }

      return res.status(INTERNAL_SERVER_ERROR).json({'Error': e.toString()});
    }
  }
}
