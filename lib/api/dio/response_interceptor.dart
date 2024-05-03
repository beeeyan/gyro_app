import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// レスポンスのサマリーをコンソールに出力する
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final stringBuffer = StringBuffer();
    debugPrint('*** Response ***');
    final requestOptions = response.requestOptions;
    stringBuffer
      ..writeln(
        '''${requestOptions.method} ${requestOptions.baseUrl}${requestOptions.path}''',
      )
      ..writeln('${response.statusCode} ${response.statusMessage}');
    // stringBuffer.write(response.headers.toString());
    // stringBuffer.write(response.data.toString());
    debugPrint(stringBuffer.toString());
    super.onResponse(response, handler);
  }
}
