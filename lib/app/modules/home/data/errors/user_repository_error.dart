final class UserRepositoryError implements Exception {
  final String label;
  final String messageError;
  final StackTrace? stackTrace;

  UserRepositoryError({
    required this.label,
    required this.messageError,
    this.stackTrace,
  });
}
