
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!await _isNetworkConnected) {
      return handler.reject(
        DioException(
          error: ErrorCode.networkNotConnected,
          requestOptions: options,
        ),
      );
    }
    return handler.next(options);
  }

}

/// インターネットに接続しているかどうか
Future<bool> get _isNetworkConnected async {
  final result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}

/// HTTP 通信でのエラーの種別の列挙
/// いまは ConnectivityInterceptor で onRequest をインターセプトして
/// ネットワーク接続を確認したときに、接続がない場合の networkNotConnected しかない。
/// 必要に応じて増やす。
enum ErrorCode {
  networkNotConnected,
}
