import '../models/todo_model.dart';

abstract interface class TodoRepository {
  Future<List<TodoModel>> getTodos();
  Future<void> createTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
  Future<TodoModel> getTodoById(int id);
}
