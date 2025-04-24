import 'package:dartonic/dartonic.dart';
import 'package:todos_api_rest_with_darto/schemas/todo_schema.dart';

final dartonic = Dartonic('sqlite::memory:', schemas: [todoSchema]);
final db = dartonic.instance;
