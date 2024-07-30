import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../api/api_consumer.dart';
import '../api/status_code.dart';
import '../error/exceptions.dart';

class DioService {
  final Dio dio;

  DioService(this.dio);

  DioService init() {
    //allow bad certificate
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options = BaseOptions(
        baseUrl: "",
        receiveTimeout: const Duration(minutes: 5),
        connectTimeout: const Duration(minutes: 5));
    _addInterceptor();
    return this;
  }

  void _addInterceptor() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (option, handler) {
          print("onRequest");
          return handler.next(option);
        },
        onResponse: (option, handler) {
          return handler.next(option);
        },
        onError: (option, handler) {
          print("onError");
          return handler.next(option);
        }));
  }

  DioService setupToken(String? accessToken) {
    dio.options.headers["Authorization"] = "Bearer $accessToken";
    return this;
  }

  _showResponseConsole(Response response) {
    if (response.data is Map<dynamic, dynamic>) {
      var data = Map<String, dynamic>.from(response.data);
      print(data);
    } else if (response.data is List<dynamic>) {
      var data = List.from(response.data);
      // ignore: avoid_print
      print("RESPONSE: $data");
    }
  }


  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();
      case DioExceptionType.badCertificate:
        throw const BadCertificateException();
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
    }
  }
}
