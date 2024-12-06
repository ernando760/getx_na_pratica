import '../../errors/base_exception.dart';

final class HttpClientError extends BaseException {
  HttpClientError({
    required super.label,
    required super.messageError,
    required super.stackTrace,
  });
}
