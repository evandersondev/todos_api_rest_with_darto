import 'package:darto/darto.dart';

class TodoController {
  int _idCounter = 1;
  final List _todos = [];

  void getAll(Request req, Response res) {
    return res.status(200).json(_todos);
  }

  Future<void> create(Request req, Response res) async {
    final body = await req.body;

    final todo = {'id': _idCounter++, ...body};
    _todos.add(todo);

    return res.status(201).end();
  }

  void update(Request req, Response res) async {
    final id = int.parse(req.params['id'] ?? '');
    final body = await req.body;

    final index = _todos.indexWhere((todo) => todo['id'] == id);

    if (index == -1) return res.status(404).send('Todo not found!');
    _todos[index] = {'id': id, ...body};
    return res.status(200).json(_todos[index]);
  }

  void delete(Request req, Response res) {
    final id = int.parse(req.params['id'] ?? '');
    _todos.removeWhere((todo) => todo['id'] == id);

    return res.status(204).end();
  }
}
