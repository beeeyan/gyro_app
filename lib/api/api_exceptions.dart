import 'api_error_messages.dart';

/// HTTP 通信時に使用する例外型。
class ApiException implements Exception {
  const ApiException({
    this.code,
    this.message,
    this.defaultMessage = serverConnectionFailure,
});

  /// ステータスコードや独自のエラーコードなどのエラー種別を識別するための文字列
  final String? code;

  /// 例外の内容を説明するメッセージ
  final String? message;

  /// message が空の場合にtoString()内で使用されるメッセージ
  final String defaultMessage;

  @override
  String toString() {
    if (code == null) {
      return (message ?? '').isEmpty ? defaultMessage : message!;
    }
    return '[$code] ${(message ?? '').isEmpty ? defaultMessage : message}';
  }
}

/// HTTP リクエストで 401 が発生した場合の例外
/// HTTP リクエストで 401 が発生した場合の例外
class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.message})
      : super(
          code: '401',
          defaultMessage: unauthorized,
        );
}

/// HTTP リクエストで 403 が発生した場合の例外
class ForbiddenException extends ApiException {
  const ForbiddenException({super.message})
      : super(
          code: '403',
          defaultMessage: forbidden,
        );
}

/// HTTP リクエストで 404 が発生した場合の例外
class ApiNotFoundException extends ApiException {
  const ApiNotFoundException({super.message})
      : super(
          code: '404',
          defaultMessage: apiNotFound,
        );
}

/// HTTP リクエストがタイムアウトした場合の例外
class ApiTimeoutException extends ApiException {
  const ApiTimeoutException({super.message})
      : super(
          defaultMessage: apiTimeout,
        );
}

/// HTTP リクエスト時のネットワーク接続に問題がある場合の例外
class NetworkNotConnectedException extends ApiException {
  const NetworkNotConnectedException({super.message})
      : super(
          defaultMessage: apiNetworkNotConnected,
        );
}
