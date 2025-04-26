import 'package:zard/zard.dart';

final createTodoBodySchema = z.map({
  'title': z.string().min(
    3,
    message: 'O título deve ter pelo menos 3 caracteres',
  ),
  'completed': z.bool().optional(),
});
