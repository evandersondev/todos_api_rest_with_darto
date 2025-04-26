import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/config/inject.dart';
import 'package:todos_api_rest_with_darto/database/db.dart';
import 'package:todos_api_rest_with_darto/middlewares/error_handler.dart';
import 'package:todos_api_rest_with_darto/middlewares/log_middleware.dart';
import 'package:todos_api_rest_with_darto/router.dart';

void main() async {
  Inject.init();

  await dartonic.sync();

  final app = Darto();

  // Middlewares
  app.use(errorHandler);
  app.use(logMiddleware);

  // Routes
  app.use('/api/v1', rootRouter());

  app.listen(3000, () {
    print('🚀 APIzinha marota rodando linda na porta 3000');
  });
}
