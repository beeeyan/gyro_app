// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_response_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BaseResponseData _$BaseResponseDataFromJson(Map<String, dynamic> json) {
  return _BaseResponseData.fromJson(json);
}

/// @nodoc
mixin _$BaseResponseData {
  Map<String, dynamic> get main => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseResponseDataCopyWith<BaseResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseResponseDataCopyWith<$Res> {
  factory $BaseResponseDataCopyWith(
          BaseResponseData value, $Res Function(BaseResponseData) then) =
      _$BaseResponseDataCopyWithImpl<$Res, BaseResponseData>;
  @useResult
  $Res call({Map<String, dynamic> main});
}

/// @nodoc
class _$BaseResponseDataCopyWithImpl<$Res, $Val extends BaseResponseData>
    implements $BaseResponseDataCopyWith<$Res> {
  _$BaseResponseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
  }) {
    return _then(_value.copyWith(
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BaseResponseDataCopyWith<$Res>
    implements $BaseResponseDataCopyWith<$Res> {
  factory _$$_BaseResponseDataCopyWith(
          _$_BaseResponseData value, $Res Function(_$_BaseResponseData) then) =
      __$$_BaseResponseDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> main});
}

/// @nodoc
class __$$_BaseResponseDataCopyWithImpl<$Res>
    extends _$BaseResponseDataCopyWithImpl<$Res, _$_BaseResponseData>
    implements _$$_BaseResponseDataCopyWith<$Res> {
  __$$_BaseResponseDataCopyWithImpl(
      _$_BaseResponseData _value, $Res Function(_$_BaseResponseData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? main = null,
  }) {
    return _then(_$_BaseResponseData(
      main: null == main
          ? _value._main
          : main // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BaseResponseData implements _BaseResponseData {
  const _$_BaseResponseData({final Map<String, dynamic> main = emptyMap})
      : _main = main;

  factory _$_BaseResponseData.fromJson(Map<String, dynamic> json) =>
      _$$_BaseResponseDataFromJson(json);

  final Map<String, dynamic> _main;
  @override
  @JsonKey()
  Map<String, dynamic> get main {
    if (_main is EqualUnmodifiableMapView) return _main;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_main);
  }

  @override
  String toString() {
    return 'BaseResponseData(main: $main)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BaseResponseData &&
            const DeepCollectionEquality().equals(other._main, _main));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_main));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BaseResponseDataCopyWith<_$_BaseResponseData> get copyWith =>
      __$$_BaseResponseDataCopyWithImpl<_$_BaseResponseData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BaseResponseDataToJson(
      this,
    );
  }
}

abstract class _BaseResponseData implements BaseResponseData {
  const factory _BaseResponseData({final Map<String, dynamic> main}) =
      _$_BaseResponseData;

  factory _BaseResponseData.fromJson(Map<String, dynamic> json) =
      _$_BaseResponseData.fromJson;

  @override
  Map<String, dynamic> get main;
  @override
  @JsonKey(ignore: true)
  _$$_BaseResponseDataCopyWith<_$_BaseResponseData> get copyWith =>
      throw _privateConstructorUsedError;
}
