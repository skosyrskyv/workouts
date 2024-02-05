// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ErrorDetailModel _$ErrorDetailModelFromJson(Map<String, dynamic> json) {
  return _ErrorDetailModel.fromJson(json);
}

/// @nodoc
mixin _$ErrorDetailModel {
  String get code => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorDetailModelCopyWith<ErrorDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorDetailModelCopyWith<$Res> {
  factory $ErrorDetailModelCopyWith(
          ErrorDetailModel value, $Res Function(ErrorDetailModel) then) =
      _$ErrorDetailModelCopyWithImpl<$Res, ErrorDetailModel>;
  @useResult
  $Res call({String code, String detail});
}

/// @nodoc
class _$ErrorDetailModelCopyWithImpl<$Res, $Val extends ErrorDetailModel>
    implements $ErrorDetailModelCopyWith<$Res> {
  _$ErrorDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? detail = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorDetailModelImplCopyWith<$Res>
    implements $ErrorDetailModelCopyWith<$Res> {
  factory _$$ErrorDetailModelImplCopyWith(_$ErrorDetailModelImpl value,
          $Res Function(_$ErrorDetailModelImpl) then) =
      __$$ErrorDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String detail});
}

/// @nodoc
class __$$ErrorDetailModelImplCopyWithImpl<$Res>
    extends _$ErrorDetailModelCopyWithImpl<$Res, _$ErrorDetailModelImpl>
    implements _$$ErrorDetailModelImplCopyWith<$Res> {
  __$$ErrorDetailModelImplCopyWithImpl(_$ErrorDetailModelImpl _value,
      $Res Function(_$ErrorDetailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? detail = null,
  }) {
    return _then(_$ErrorDetailModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      detail: null == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorDetailModelImpl implements _ErrorDetailModel {
  _$ErrorDetailModelImpl({required this.code, required this.detail});

  factory _$ErrorDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorDetailModelImplFromJson(json);

  @override
  final String code;
  @override
  final String detail;

  @override
  String toString() {
    return 'ErrorDetailModel(code: $code, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorDetailModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, detail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorDetailModelImplCopyWith<_$ErrorDetailModelImpl> get copyWith =>
      __$$ErrorDetailModelImplCopyWithImpl<_$ErrorDetailModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorDetailModelImplToJson(
      this,
    );
  }
}

abstract class _ErrorDetailModel implements ErrorDetailModel {
  factory _ErrorDetailModel(
      {required final String code,
      required final String detail}) = _$ErrorDetailModelImpl;

  factory _ErrorDetailModel.fromJson(Map<String, dynamic> json) =
      _$ErrorDetailModelImpl.fromJson;

  @override
  String get code;
  @override
  String get detail;
  @override
  @JsonKey(ignore: true)
  _$$ErrorDetailModelImplCopyWith<_$ErrorDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
