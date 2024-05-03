import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../util/empty_map.dart';
import '../api.dart';

part 'base_response_data.freezed.dart';
part 'base_response_data.g.dart';

/// アプリケーションで取り扱う HTTP のレスポンスボディのベースとなる型
/// HTTP のレスポンスボディは、ApiClient の返り値の時点ですべて
/// ApiResponse.fromDynamic(responseData) で BaseResponseData 型のインスタンスに変換される。
/// ※ 別パターンではsuccessのbool値や、messageを持つものもある。
@freezed
class BaseResponseData with _$BaseResponseData {
  const factory BaseResponseData({
    @Default(emptyMap) Map<String, dynamic> main,
  }) = _BaseResponseData;

  factory BaseResponseData.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseDataFromJson(json);

  /// HTTP レスポンスのレスポンスデータの方は不定 (dynamic) なので、
  /// それらのレスポンスデータはすべてこの fromDynamic コンストラクタに渡して、
  /// dynamic を適当に Map<String, dynamic> に変更した上で、fromJson コンストラクタに渡して
  /// BaseResponseData インスタンスを生成して返す。
  factory BaseResponseData.fromDynamic(dynamic responseData) {
    final json = toResponseJson(responseData);

    return BaseResponseData.fromJson(
      <String, dynamic>{
        // キーと値をmainに格納する
        'main': <String, dynamic>{
          for (final k in json.keys) ...<String, dynamic>{k: json[k]},
        },
      },
    );
  }
}
