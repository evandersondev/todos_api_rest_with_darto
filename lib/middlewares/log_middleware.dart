logMiddleware(req, res, next) {
  print('[${req.method}] ${req.baseUrl}${req.path} - ${DateTime.now()}');
  next();
}
