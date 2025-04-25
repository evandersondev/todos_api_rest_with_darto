import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/services/todo_service.dart';
import 'package:zard/zard.dart';

import '../models/todo_model.dart';

class TodoController {
  final TodoService _service;

  TodoController(this._service);

  void getAll(Request req, Response res) async {
    final todos = await _service.getTodos();

    return res.status(200).json(todos);
  }

  Future<void> create(Request req, Response res) async {
    final todoBodySchema = z.map({
      'title': z.string().min(3),
      'completed': z.bool().optional(),
    });

    try {
      final todo = todoBodySchema.parse(await req.body);
      await _service.createTodo(TodoModel.fromJson(todo!));

      return res.status(201).end();
    } catch (e) {
      if (e is ZardError) {
        return res.status(NOT_ACCEPTABLE).json({'Errors': e.format()});
      }

      return res.status(500).json({'Error': e.toString()});
    }
  }

  void update(Request req, Response res) async {
    final paramSchema = z.coerce.int();
    final todoBodySchema = z.map({
      'title': z.string().min(3),
      'completed': z.bool().optional(),
    });

    try {
      final id = paramSchema.parse(req.params['id']);
      final body = todoBodySchema.parse(await req.body);

      final todo = await _service.updateTodo(
        TodoModel.fromJson({...body!, 'id': id}),
      );

      return res.status(200).json(todo);
    } catch (e) {
      if (e is ZardError) {
        return res.status(500).json({'Errors': e.format()});
      }

      return res.status(500).json({'Error': e.toString()});
    }
  }

  void delete(Request req, Response res) async {
    final paramSchema = z.coerce.int();

    try {
      final id = paramSchema.parse(req.params['id'] ?? '');

      await _service.deleteTodo(id);
    } catch (e) {
      if (e is ZardError) {
        return res.status(500).json({'Errors': e.format()});
      }

      return res.status(500).json({'Error': e.toString()});
    }

    return res.status(204).end();
  }
}
