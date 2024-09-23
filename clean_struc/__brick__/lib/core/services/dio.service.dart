import 'dart:developer';

import 'package:deep_pick/deep_pick.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nanoid2/nanoid2.dart';

import '../error/exceptions.dart';
import '../utils/extension.dart';
import '../utils/safe.dart';

@lazySingleton
class DioService {
  @postConstruct
  Future<void> init() async {
    _dio.interceptors.add(interceptorWrap());
    _dio.options.baseUrl = '{{{baseUrl}}}';
  }

  final Dio _dio = Dio();
  static const xRequestId = 'X-Request-ID';

  Future<Response<T>> post<T>(String url, Map<String, dynamic> data) async {
    return _dio.post(url, data: data);
  }

  Future<Response<T>> patch<T>(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.patch<T>(url, data: data);
    } on DioException catch (e) {
      throw ServerException(e.message!);
    }
  }

  InterceptorsWrapper interceptorWrap() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final requestId = nanoid();
        final curl = safe(() => options.toCurlCmd());

        log('''
Request: $requestId
$curl
''');

        return handler.next(options);
      },
      onResponse: (response, handler) {
        final requestId =
            pick(response.requestOptions.headers, xRequestId).asStringOrNull();
        final message = '${response.statusCode} | ${response.statusMessage}';
        log('''
        Response: $requestId
        $message
      ''');
        return handler.next(response);
      },
      onError: (e, handler) {
        final requestId =
            pick(e.requestOptions.headers, xRequestId).asStringOrNull();

        log('''
        Error: $requestId
        ${e.message}
      ''');

        return handler.next(e);
      },
    );
  }

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    final response = await _dio.get<T>(url);
    return response;
  }
}

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio();
}
