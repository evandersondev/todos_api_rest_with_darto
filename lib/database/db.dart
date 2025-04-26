import 'package:dartonic/dartonic.dart';

import '../schemas/tables/todo_table_schema.dart';

final dartonic = Dartonic('sqlite::memory:', schemas: [todoTableSchema]);
final db = dartonic.instance;
