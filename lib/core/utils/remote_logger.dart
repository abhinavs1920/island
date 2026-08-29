import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RemoteLogger {
  static const String _endpoint = 'https://crudcrud.com/api/b6c4339a452344c29ff292aa7e96ecdc/logs';
  static final Dio _dio = Dio();

  static void init() {
    // Override default print
    debugPrint = (String? message, {int? wrapWidth}) {
      _sendToRemote('INFO', message ?? 'null');
      // Still print to local console
      if (message != null) {
        debugPrintSynchronously(message, wrapWidth: wrapWidth);
      }
    };

    // Override FlutterError
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      _sendToRemote('ERROR', '${details.exceptionAsString()}\n${details.stack}');
      if (originalOnError != null) {
        originalOnError(details);
      }
    };

    // Override PlatformDispatcher for async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      _sendToRemote('FATAL', '$error\n$stack');
      return true;
    };
    
    log('RemoteLogger initialized');
  }

  static void log(String message) {
    _sendToRemote('INFO', message);
    debugPrintSynchronously('[RemoteLogger] $message');
  }

  static void error(String message, [dynamic error, StackTrace? stack]) {
    _sendToRemote('ERROR', '$message\n$error\n$stack');
    debugPrintSynchronously('[RemoteLogger ERROR] $message\n$error');
  }

  static Future<void> _sendToRemote(String level, String message) async {
    try {
      // Fire and forget
      _dio.post(
        _endpoint,
        data: {
          'level': level,
          'message': message,
          'timestamp': DateTime.now().toUtc().toIso8601String(),
        },
      ).catchError((_) {});
    } catch (e) {
      // Ignore
    }
  }
}

class RemoteLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    RemoteLogger.log('HTTP REQ: ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RemoteLogger.log('HTTP RES: ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    RemoteLogger.error('HTTP ERR: ${err.message} ${err.requestOptions.uri}');
    super.onError(err, handler);
  }
}
