abstract class BaseException implements Exception {
  final String label;
  final String messageError;
  final StackTrace? stackTrace;

  BaseException(
      {required this.label, required this.messageError, this.stackTrace});
}
