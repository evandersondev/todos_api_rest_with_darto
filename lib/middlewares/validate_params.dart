import 'package:darto/darto.dart';
import 'package:zard/zard.dart';

Middleware validateParams(Schema schema) {
  return (Request req, Response res, Next next) async {
    final result = await schema.safeParseAsync(req.params);

    if (!result['success']) {
      return res.status(BAD_REQUEST).json(result['errors']);
    }

    req.context['validateParam'] = result['data'];
    return next();
  };
}
