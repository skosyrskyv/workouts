import 'package:dio/dio.dart';
import 'package:workouts/core/network/client/error/error_model/error_model.dart';
import 'package:workouts/core/network/client/exceptions/cancel_exception.dart';
import 'package:workouts/core/network/client/exceptions/client_exception.dart';
import 'package:workouts/core/network/client/exceptions/timeout_exception.dart';

import 'package:injectable/injectable.dart';

import 'dio_client_settings.dart';
import 'exceptions/server_exception.dart';
import 'http_client.dart';
import 'http_response.dart';

@singleton
class DioClient implements IHttpClient {
  static final Dio _client = Dio(DioClientSettings.buildSettings());

  const DioClient();

  Future<HttpResponse> _checkResponse(Response? response) async {
    if (response == null || response.statusCode == null) {
      throw Exception('Response is null or status code is null');
    }

    if (response.statusCode! >= 500) {
      throw ServerException(response.data);
    }

    if (response.statusCode! >= 400 && response.statusCode! < 500) {
      throw ClientException(
        ErrorModel.fromJson(response.data),
      );
    }

    if (response.statusCode! < 400) {
      throw Exception(response.data);
    }

    return HttpResponse(
      data: response.data,
      headers: response.headers,
      statusCode: response.statusCode,
    );
  }

  Future<HttpResponse> _errorHandler(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw TimeoutException();
      case DioExceptionType.receiveTimeout:
        throw TimeoutException();
      case DioExceptionType.sendTimeout:
        throw TimeoutException();
      case DioExceptionType.cancel:
        throw CancelException();
      case DioExceptionType.badResponse:
        return await _checkResponse(error.response);
      case DioExceptionType.badCertificate:
        throw Exception('Bad Certificate');
      case DioExceptionType.connectionError:
        throw Exception('Connection error');
      case DioExceptionType.unknown:
        throw Exception('Unexpected dio request error: ${error.toString()}');
    }
  }

  @override
  Future<HttpResponse> get({
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _client.get(
        path,
        queryParameters: params,
        options: Options(headers: headers),
      );
      return await _checkResponse(response);
    } on DioException catch (error) {
      return await _errorHandler(error);
    } catch (exception, stacktrace) {
      throw Error.throwWithStackTrace(exception, stacktrace);
    }
  }

  @override
  Future<HttpResponse> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _client.post(
        path,
        queryParameters: params,
        data: data,
        options: Options(headers: headers),
      );
      return await _checkResponse(response);
    } on DioException catch (error) {
      return await _errorHandler(error);
    } catch (exception, stacktrace) {
      throw Error.throwWithStackTrace(exception, stacktrace);
    }
  }

  @override
  Future<HttpResponse> patch({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _client.patch(
        path,
        queryParameters: params,
        data: data,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on DioException catch (error) {
      return await _errorHandler(error);
    } catch (exception, stacktrace) {
      throw Error.throwWithStackTrace(exception, stacktrace);
    }
  }

  @override
  Future<HttpResponse> delete({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _client.delete(
        path,
        queryParameters: params,
        data: data,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on DioException catch (error) {
      return await _errorHandler(error);
    } catch (exception, stacktrace) {
      throw Error.throwWithStackTrace(exception, stacktrace);
    }
  }

  @override
  Future<HttpResponse> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _client.put(
        path,
        queryParameters: params,
        data: data,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on DioException catch (error) {
      return await _errorHandler(error);
    } catch (exception, stacktrace) {
      throw Error.throwWithStackTrace(exception, stacktrace);
    }
  }

  @override
  Future<HttpResponse> customFetch({
    required Uri uri,
    required String method,
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _client.fetch(
        RequestOptions(
          baseUrl: '${uri.scheme}://${uri.host}',
          path: uri.path,
          method: method,
          data: data,
          headers: headers,
          queryParameters: params,
        ),
      );
      return _checkResponse(response);
    } on DioException catch (error) {
      return await _errorHandler(error);
    } catch (exception, stacktrace) {
      throw Error.throwWithStackTrace(exception, stacktrace);
    }
  }
}
