import 'package:dartonic/dartonic.dart';

import '../schemas/todo_schema.dart';

final dartonic = Dartonic('sqlite::memory:', schemas: [todoSchema]);
final db = dartonic.instance;
