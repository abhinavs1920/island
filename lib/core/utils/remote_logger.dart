import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RemoteLogger {
  static const String _endpoint = 'https://women-vegetation-recreation-josh.trycloudflare.com/';
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 2),
      sendTimeout: const Duration(seconds: 2),
      receiveTimeout: const Duration(seconds: 2),
    ),
  );

  static void init() {
    // Override default print
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) {
        debugPrintSynchronously(message, wrapWidth: wrapWidth);
      }
    };

    // Override FlutterError
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      debugPrintSynchronously('[FlutterError] ${details.exceptionAsString()}');
      _sendToRemote('ERROR', '${details.exceptionAsString()}\n${details.stack}');
      if (originalOnError != null) {
        originalOnError(details);
      }
    };

    // Override PlatformDispatcher for async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      debugPrintSynchronously('[AsyncPlatformError] $error');
      _sendToRemote('FATAL', '$error\n$stack');
      return true;
    };
    
    log('RemoteLogger initialized');
  }

  static void log(String message) {
    debugPrintSynchronously('[RemoteLogger] $message');
    _sendToRemote('INFO', message);
  }

  static void error(String message, [dynamic error, StackTrace? stack]) {
    debugPrintSynchronously('[RemoteLogger ERROR] $message\n$error');
    _sendToRemote('ERROR', '$message\n$error\n$stack');
  }

  static Future<void> _sendToRemote(String level, String message) async {
    try {
      await _dio.post(
        _endpoint,
        data: {
          'level': level,
          'message': message,
          'timestamp': DateTime.now().toUtc().toIso8601String(),
        },
      );
    } catch (_) {
      // Safe no-op without infinite recursion
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
