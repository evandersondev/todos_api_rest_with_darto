import 'package:darto/darto.dart';
import 'package:dartonic/dartonic.dart';
import 'package:todos_api_rest_with_darto/database/db.dart';
import 'package:zard/zard.dart';

class TodoController {
  void getAll(Request req, Response res) async {
    final todos = await db.select().from('todos');
    return res.status(200).json(todos);
  }

  Future<void> create(Request req, Response res) async {
    final todoBodySchema = z.map({
      'title': z.string().min(3),
      // 'completed': z.bool().nullable(),
    });

    try {
      final todo = todoBodySchema.parse(await req.body)!;
      await db.insert('todos').values(todo);

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

      final userExists = await db
          .select()
          .from('todos')
          .where(eq('todo.id', id));

      if (userExists) return res.status(404).send('Todo not found!');

      final todo =
          await db
              .update('todos')
              .values(body)
              .where(eq('todo.id', id))
              .returning();

      return res.status(200).json(todo);
    } catch (e) {
      return res.status(500).json({
        'Errors': [...todoBodySchema.getErrors(), ...paramSchema.getErrors()],
      });
    }
  }

  void delete(Request req, Response res) async {
    final paramSchema = z.coerce.int();

    try {
      final id = paramSchema.parse(req.params['id'] ?? '');

      await db.delete('todos').where(eq('todo.id', id));
    } catch (e) {
      return res.status(500).json({'Errors': paramSchema.getErrors()});
    }

    return res.status(204).end();
  }
}
