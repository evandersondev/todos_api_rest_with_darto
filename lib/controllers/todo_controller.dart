import 'package:darto/darto.dart';
import 'package:zard/zard.dart';

class TodoController {
  int _idCounter = 1;
  final List _todos = [];

  void getAll(Request req, Response res) {
    return res.status(200).json(_todos);
  }

  Future<void> create(Request req, Response res) async {
    final todoBodySchema = z.map({
      'title': z.string().min(3),
      'completed': z.bool().optional(),
    });

    try {
      final todo = todoBodySchema.parse(await req.body)!;
      _todos.add({...todo, 'id': _idCounter++});

      return res.status(201).end();
    } catch (e) {
      return res.status(500).json({'Errors': todoBodySchema.getErrors()});
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

      final body = todoBodySchema.parse(await req.body)!;

      final index = _todos.indexWhere((todo) => todo['id'] == id);

      if (index == -1) return res.status(404).send('Todo not found!');
      _todos[index] = {'id': id, ...body};
      return res.status(200).json(_todos[index]);
    } catch (e) {
      return res.status(500).json({
        'Errors': [...todoBodySchema.getErrors(), ...paramSchema.getErrors()],
      });
    }
  }

  void delete(Request req, Response res) {
    final paramSchema = z.coerce.int();

    try {
      final id = paramSchema.parse(req.params['id'] ?? '');

      _todos.removeWhere((todo) => todo['id'] == id);
    } catch (e) {
      return res.status(500).json({'Errors': paramSchema.getErrors()});
    }

    return res.status(204).end();
  }
}
