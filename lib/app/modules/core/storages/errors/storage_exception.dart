import 'package:getx_na_pratica/app/modules/core/services/errors/base_exception.dart';

class StorageException extends BaseException {
  StorageException({
    required super.label,
    required super.messageError,
    required super.stackTrace,
  });
}
