import 'package:dartonic/dartonic.dart';

import '../../database/db.dart';
import '../../models/todo_model.dart';
import '../todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<TodoModel>> getTodos() async {
    final todos = await db.select().from('todos') as List;

    return Future.value(todos.map((todo) => TodoModel.fromJson(todo)).toList());
  }

  @override
  Future<void> createTodo(TodoModel todo) async {
    await db.insert('todos').values(todo.toJson());
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    final result =
        await db
            .update('todos')
            .set(todo.toJson())
            .where(eq('todos.id', todo.id))
            .returning();

    return Future.value(TodoModel.fromJson(result.first));
  }

  @override
  Future<void> deleteTodo(int id) async {
    await db.delete('todos').where(eq('todos.id', id));
  }

  @override
  Future<TodoModel?> getTodoById(int id) async {
    final result = await db.select().from('todos').where(eq('todos.id', id));
    return Future.value(TodoModel.fromJson(result.first));
  }
}
