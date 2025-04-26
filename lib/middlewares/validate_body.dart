import 'package:darto/darto.dart';
import 'package:zard/zard.dart';

Middleware validateBody(Schema schema) {
  return (Request req, Response res, Next next) async {
    final result = await schema.safeParseAsync(req.body);

    if (!result['success']) {
      return res.status(BAD_REQUEST).json(result['errors']);
    }

    req.context['validateBody'] = result['data'];
    return next();
  };
}
