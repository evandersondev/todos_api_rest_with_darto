import '../errors/app_exception.dart';
import '../models/todo_model.dart';
import '../repositories/todo_repository.dart';

class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  Future<List<TodoModel>> getTodos() {
    return _repository.getTodos();
  }

  Future<void> createTodo(TodoModel todo) {
    return _repository.createTodo(todo);
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      final todoExists = await _repository.getTodoById(todo.id!);

      if (todoExists == null) {
        throw NotFoundException('Todo not found');
      }

      return _repository.updateTodo(todo);
    } catch (_) {
      throw InternalServerException('Internal server error');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final todoExists = await _repository.getTodoById(id);

      if (todoExists == null) {
        throw NotFoundException('Todo not found');
      }

      return _repository.deleteTodo(id);
    } catch (_) {
      throw InternalServerException('Internal server error');
    }
  }
}
