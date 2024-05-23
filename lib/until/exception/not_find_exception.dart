class NotFindException implements Exception {
  String message = "Не удалось найти";
  NotFindException(this.message);
}