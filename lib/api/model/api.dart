import '../../util/empty_map.dart';

/// 型不定 (dynamic) なレスポンスデータを Map<String, dynamic> に変換する。
Map<String, dynamic> toResponseJson(dynamic data) {
  if (data == null) {
    return emptyMap;
  }
  if (data is List) {
    // リストの場合は適当なキー名として 'items' をつける
    return <String, dynamic>{'items': data};
  }
  if (data is Map) {
    return data as Map<String, dynamic>;
  }
  return emptyMap;
}
