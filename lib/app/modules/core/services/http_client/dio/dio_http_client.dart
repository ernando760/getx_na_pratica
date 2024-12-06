import 'package:dio/dio.dart';

import '../errors/http_client_error.dart';
import '../interfaces/i_http_client.dart';
import '../responses/http_client_response.dart';
import 'adapters/dio_adapter.dart';

class DioHttpClient implements IHttpClient {
  DioHttpClient(this._dio);

  final Dio _dio;

  @override
  Future<HttpClientResponse> get(String path,
      {Map<String, dynamic>? data,
      CustomOptions? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        data: data,
        options: DioAdapter.toOptions(options ?? CustomOptions()),
        queryParameters: queryParameters,
      );

      final dataResponse = {
        "data": response.data,
        "status_code": response.statusCode,
      };

      return HttpClientResponse(data: dataResponse);
    } on DioException catch (e) {
      throw HttpClientError(
          label: "$runtimeType.get",
          messageError: e.message ?? "",
          stackTrace: e.stackTrace);
    } catch (e, s) {
      throw HttpClientError(
          label: "$runtimeType.get", messageError: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<HttpClientResponse> post(String path,
      {Map<String, dynamic>? data,
      CustomOptions? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: DioAdapter.toOptions(options ?? CustomOptions()),
        queryParameters: queryParameters,
      );

      final dataResponse = {
        "data": response.data,
        "status_code": response.statusCode,
      };

      return HttpClientResponse(data: dataResponse);
    } on DioException catch (e) {
      throw HttpClientError(
          label: "$runtimeType.post",
          messageError: e.message ?? "",
          stackTrace: e.stackTrace);
    } catch (e, s) {
      throw HttpClientError(
          label: "$runtimeType.post",
          messageError: e.toString(),
          stackTrace: s);
    }
  }

  @override
  Future<HttpClientResponse> delete(String path,
      {Map<String, dynamic>? data,
      CustomOptions? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        options: DioAdapter.toOptions(options ?? CustomOptions()),
        queryParameters: queryParameters,
      );

      final dataResponse = {
        "data": response.data,
        "status_code": response.statusCode,
      };

      return HttpClientResponse(data: dataResponse);
    } on DioException catch (e) {
      throw HttpClientError(
          label: "$runtimeType.delete",
          messageError: e.message ?? "",
          stackTrace: e.stackTrace);
    } catch (e, s) {
      throw HttpClientError(
          label: "$runtimeType.delete",
          messageError: e.toString(),
          stackTrace: s);
    }
  }

  @override
  Future<HttpClientResponse> put(String path,
      {Map<String, dynamic>? data,
      CustomOptions? options,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        options: DioAdapter.toOptions(options ?? CustomOptions()),
        queryParameters: queryParameters,
      );

      final dataResponse = {
        "data": response.data,
        "status_code": response.statusCode,
      };

      return HttpClientResponse(data: dataResponse);
    } on DioException catch (e) {
      throw HttpClientError(
          label: "$runtimeType.put",
          messageError: e.message ?? "",
          stackTrace: e.stackTrace);
    } catch (e, s) {
      throw HttpClientError(
          label: "$runtimeType.put", messageError: e.toString(), stackTrace: s);
    }
  }
}
