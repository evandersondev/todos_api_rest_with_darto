import 'package:dartonic/dartonic.dart';

final todoSchema = sqliteTable('todos', {
  'id': integer().primaryKey(autoIncrement: true),
  'title': text(),
  'completed': integer(mode: 'boolean').$default(0),
});
