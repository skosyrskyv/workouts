import 'package:workouts/core/network/client/error/error_detail_model/error_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

@freezed
class ErrorModel with _$ErrorModel {
  factory ErrorModel({
    required List<ErrorDetailModel> errors,
    required String type,
  }) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);
}
