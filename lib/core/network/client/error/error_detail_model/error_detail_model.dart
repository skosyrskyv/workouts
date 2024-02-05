import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_detail_model.freezed.dart';
part 'error_detail_model.g.dart';

@freezed
class ErrorDetailModel with _$ErrorDetailModel {
  factory ErrorDetailModel({
    required String code,
    required String detail,
  }) = _ErrorDetailModel;

  factory ErrorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailModelFromJson(json);
}
