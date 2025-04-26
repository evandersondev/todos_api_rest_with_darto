import 'package:zard/zard.dart';

final updateTodoBodySchema = z.map({
  'title': z.string().min(3).optional(),
  'completed': z.bool().optional(),
});
