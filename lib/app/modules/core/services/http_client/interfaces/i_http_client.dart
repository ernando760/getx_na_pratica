import 'package:dio/dio.dart';

import '../responses/http_client_response.dart';

abstract interface class IHttpClient {
  Future<HttpClientResponse> get(
    String path, {
    Map<String, dynamic>? data,
    CustomOptions? options,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpClientResponse> post(
    String path, {
    Map<String, dynamic>? data,
    CustomOptions? options,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpClientResponse> delete(
    String path, {
    Map<String, dynamic>? data,
    CustomOptions? options,
    Map<String, dynamic>? queryParameters,
  });

  Future<HttpClientResponse> put(
    String path, {
    Map<String, dynamic>? data,
    CustomOptions? options,
    Map<String, dynamic>? queryParameters,
  });
}

class CustomOptions {
  CustomOptions({
    this.method,
    this.sendTimeout,
    this.receiveTimeout,
    this.extra,
    this.headers,
    this.preserveHeaderCase,
    this.responseType,
    this.contentType,
    this.validateStatus,
    this.receiveDataWhenStatusError,
    this.followRedirects,
    this.maxRedirects,
    this.persistentConnection,
    this.requestEncoder,
    this.responseDecoder,
    this.listFormat,
  });

  final String? method;
  final Duration? sendTimeout;
  final Duration? receiveTimeout;
  final Map<String, Object?>? extra;
  final Map<String, Object?>? headers;
  final bool? preserveHeaderCase;
  final ResponseType? responseType;
  final String? contentType;
  final ValidateStatus? validateStatus;
  final bool? receiveDataWhenStatusError;
  final bool? followRedirects;
  final int? maxRedirects;
  final bool? persistentConnection;
  final RequestEncoder? requestEncoder;
  final ResponseDecoder? responseDecoder;
  final ListFormat? listFormat;
}
