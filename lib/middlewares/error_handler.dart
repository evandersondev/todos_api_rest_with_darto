import 'package:darto/darto.dart';
import 'package:todos_api_rest_with_darto/errors/app_exception.dart';
import 'package:zard/zard.dart';

void errorHandler(Err err, Request req, Response res, Next next) {
  if (err is ZardError) {
    return res.status(BAD_REQUEST).json({'error': err.format()});
  }

  if (err is NotFoundException) {
    return res.status(NOT_FOUND).json({'error': err.message});
  }

  return res.status(INTERNAL_SERVER_ERROR).json({
    'error': 'Interno server error',
  });
}
