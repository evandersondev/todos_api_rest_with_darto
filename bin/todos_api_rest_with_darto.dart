import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/router.dart';

void main() {
  final app = Darto();

  app.use('/api/v1', rootRouter());

  app.listen(3000, () {
    print('🚀 APIzinha marota rodando linda na porta 3000');
  });
}
