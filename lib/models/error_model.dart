import 'package:hive/hive.dart';

part 'error_model.g.dart';

@HiveType(typeId: 13)
class ErrorModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? questionId;

  @HiveField(2)
  int? fieldSetId;

  @HiveField(3)
  int? formId;

  @HiveField(4)
  String? errorMessage;

  ErrorModel(this.id, this.questionId, this.fieldSetId, this.formId, this.errorMessage);

  ErrorModel.fill(this.fieldSetId, this.errorMessage);
}
