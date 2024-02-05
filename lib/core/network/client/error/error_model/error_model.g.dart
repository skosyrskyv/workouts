// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorModelImpl _$$ErrorModelImplFromJson(Map<String, dynamic> json) =>
    _$ErrorModelImpl(
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ErrorDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$ErrorModelImplToJson(_$ErrorModelImpl instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'type': instance.type,
    };
