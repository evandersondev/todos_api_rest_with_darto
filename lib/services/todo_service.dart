import '../models/todo_model.dart';
import '../repositories/todo_repository.dart';

class TodoService {
  Future<List<TodoModel>> getTodos() async {
    return TodoRepository.getTodos();
  }

  Future<void> createTodo(TodoModel todo) async {
    print('Creating todo: ${todo.toJson()}');
    return TodoRepository.createTodo(todo);
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    final todoExists = await TodoRepository.getTodoById(todo.id!);

    if (todoExists.id == null) {
      throw Exception('Todo not found');
    }

    return TodoRepository.updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    final todoExists = await TodoRepository.getTodoById(id);

    if (todoExists.id == null) {
      throw Exception('Todo not found');
    }

    return TodoRepository.deleteTodo(id);
  }
}
