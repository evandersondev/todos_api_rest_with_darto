import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/controllers/todo_controller.dart';

import 'middlewares/log_middleware.dart';

Router rootRouter() {
  final router = Router();
  final todoController = TodoController();

  router.get('/todos', logMiddleware, todoController.getAll);
  router.post('/todos', logMiddleware, todoController.create);
  router.put('/todos/:id', logMiddleware, todoController.update);
  router.delete('/todos/:id', logMiddleware, todoController.delete);

  return router;
}
