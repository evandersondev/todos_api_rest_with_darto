import 'package:darto/darto.dart';

void main() {
  final app = Darto(logger: Logger(debug: true));

  int idCounter = 1;
  List todos = [];

  // GET /todos
  app.get('/todos', (Request req, Response res) {
    return res.status(200).json(todos);
  });

  // POST /todos
  app.post('/todos', (Request req, Response res) async {
    final body = await req.body;

    final todo = {'id': idCounter++, ...body};
    todos.add(todo);

    return res.status(201).end();
  });

  // PUT /todos/:id
  app.put('/todos/:id', (Request req, Response res) async {
    final id = int.parse(req.params['id'] ?? '');
    final body = await req.body;

    final index = todos.indexWhere((todo) => todo['id'] == id);

    if (index == -1) return res.status(404).send('Todo not found!');
    todos[index] = {'id': id, ...body};
    return res.status(200).json(todos[index]);
  });

  // DELETE /todos/:id
  app.delete('/todos/:id', (Request req, Response res) {
    final id = int.parse(req.params['id'] ?? '');
    todos.removeWhere((todo) => todo['id'] == id);

    return res.status(204).end();
  });

  app.listen(3000, () {
    print('🚀 APIzinha marota rodando linda na porta 3000');
  });
}
