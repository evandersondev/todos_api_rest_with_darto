import 'package:darto/darto.dart';
import 'package:injectfy/injectfy.dart';
import 'package:todos_api_rest_with_darto/controllers/todo_controller.dart';
import 'package:todos_api_rest_with_darto/middlewares/validate_body.dart';
import 'package:todos_api_rest_with_darto/middlewares/validate_params.dart';
import 'package:todos_api_rest_with_darto/schemas/validations/create_todo_body_schema.dart';
import 'package:todos_api_rest_with_darto/schemas/validations/update_todo_body_schema.dart';

import 'schemas/validations/id_param_schema.dart';

Router rootRouter() {
  final router = Router();
  final todoController = Injectfy.get<TodoController>();

  router.get('/todos', todoController.getAll);
  router.post(
    '/todos',
    validateBody(createTodoBodySchema),
    todoController.create,
  );
  router.put(
    '/todos/:id',
    validateParams(idParamSchema),
    validateBody(updateTodoBodySchema),
    todoController.update,
  );
  router.delete(
    '/todos/:id',
    validateParams(idParamSchema),
    todoController.delete,
  );

  return router;
}
