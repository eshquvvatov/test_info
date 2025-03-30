import 'dart:io';
import 'package:aros_staff/config/routes/router_names.dart';
import 'package:dio/dio.dart';

import '../../config/routes/app_route.dart';
import '../../features/auth/data/data_sources/local/auth_local_data_source.dart';
import '../di/service_locator.dart';
import '../utils/logger.dart';

class DioClient {
  final Dio _dio;
  final AuthUserLocalDataSource _dataSource;
  final String _baseUrl;

  DioClient({
    required Dio dio,
    required AuthUserLocalDataSource dataSource,
    required String baseUrl,
  })  : _dio = dio,
        _dataSource = dataSource,
        _baseUrl = baseUrl {
    _initDio();
  }

  void _initDio() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return status != null && status < 205;
      },
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
      onResponse: _onResponse,
    ));
  }

  Future<void> _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    _logRequest(options);

  
    final token = _dataSource.getOtpToken();
    if (token != null && token.access.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${token.access}';
    }

    handler.next(options);
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    handler.next(response);
  }

  Future<void> _onError(
      DioException err, ErrorInterceptorHandler handler) async {
    _logError(err);

    if (err.error is SocketException) {
      final socketError = DioException(
        requestOptions: err.requestOptions,
        error: const HttpException("Internet connection unavailable"),
        message: "Internet connection unavailable",
      );
      return handler.next(socketError);
    }

    if (err.response?.statusCode == 401 ) {
      return sl<AppRouter>().router.go(AppRoutesName.signIn);
    }

    handler.next(err);
  }







  void _logRequest(RequestOptions options) {
    final method = options.method.toUpperCase();
    final path = options.path;
    final data = options.data?.toString() ?? 'No body';
    final queryParams = options.queryParameters.isNotEmpty
        ? '?${options.queryParameters}'
        : '';

    LogService.i('🌐 [$method] $path$queryParams');
    LogService.i('📦 Request Body: $data');
  }

  void _logResponse(Response response) {
    final statusCode = response.statusCode;
    final path = response.requestOptions.path;
    final data = response.data?.toString() ?? 'Empty response';

    LogService.i('✅ [$statusCode] $path');
    LogService.i('📦 Response: $data');
  }

  void _logError(DioException err) {
    final statusCode = err.response?.statusCode ?? 'No status';
    final path = err.requestOptions.path;
    final message = err.message ?? 'Unknown error';
    final error = err.error?.toString() ?? 'No error details';

    LogService.e('❌ [$statusCode] $path');
    LogService.e('⚠️ Error: $message');
    LogService.w('🔧 Details: $error');
  }

  Dio get dio => _dio;
}