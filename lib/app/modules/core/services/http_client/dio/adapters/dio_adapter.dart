import 'package:dio/dio.dart';

import '../../interfaces/i_http_client.dart';

class DioAdapter {
  static Options toOptions(CustomOptions customOptions) => Options(
        method: customOptions.method,
        headers: customOptions.headers,
        extra: customOptions.extra,
        contentType: customOptions.contentType,
        receiveTimeout: customOptions.receiveTimeout,
        sendTimeout: customOptions.sendTimeout,
        receiveDataWhenStatusError: customOptions.receiveDataWhenStatusError,
        persistentConnection: customOptions.persistentConnection,
        validateStatus: customOptions.validateStatus,
        followRedirects: customOptions.followRedirects,
        listFormat: customOptions.listFormat,
        maxRedirects: customOptions.maxRedirects,
        preserveHeaderCase: customOptions.preserveHeaderCase,
        requestEncoder: customOptions.requestEncoder,
        responseDecoder: customOptions.responseDecoder,
        responseType: customOptions.responseType,
      );
}
