import '../models/todo_model.dart';
import '../repositories/todo_repository.dart';

class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  Future<List<TodoModel>> getTodos() async {
    return _repository.getTodos();
  }

  Future<void> createTodo(TodoModel todo) async {
    return _repository.createTodo(todo);
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    final todoExists = await _repository.getTodoById(todo.id!);

    if (todoExists.id == null) {
      throw Exception('Todo not found');
    }

    return _repository.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    final todoExists = await _repository.getTodoById(id);

    if (todoExists.id == null) {
      throw Exception('Todo not found');
    }

    return _repository.deleteTodo(id);
  }
}
