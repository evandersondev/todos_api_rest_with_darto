import 'package:dartonic/dartonic.dart';

import '../database/db.dart';
import '../models/todo_model.dart';

class TodoRepository {
  static Future<List<TodoModel>> getTodos() async {
    final todos = await db.select().from('todos') as List;

    return Future.value(todos.map((todo) => TodoModel.fromJson(todo)).toList());
  }

  static Future<void> createTodo(TodoModel todo) async {
    print(todo.toJson());
    await db.insert('todos').values(todo.toJson());
  }

  static Future<TodoModel> updateTodo(TodoModel todo) async {
    final result =
        await db
            .update('todos')
            .set(todo.toJson())
            .where(eq('todos.id', todo.id))
            .returning();

    return Future.value(TodoModel.fromJson(result.first));
  }

  static Future<void> deleteTodo(int id) async {
    await db.delete('todos').where(eq('todos.id', id));
  }

  static Future<TodoModel> getTodoById(int id) async {
    final result = await db.select().from('todos').where(eq('todos.id', id));
    return Future.value(TodoModel.fromJson(result.first));
  }
}
