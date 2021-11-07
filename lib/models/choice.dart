import 'package:hive/hive.dart';
import 'package:rightnow/views/language_switch.dart';

part 'choice.g.dart';

@HiveType(typeId: 9)
class Choice {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? label;

  @HiveField(2)
  String? labelAr;

  @HiveField(3)
  bool? isOther;

  @HiveField(4)
  int? questionId;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? label : labelAr) ?? "";
  }

  Choice(this.id, this.label, this.labelAr, this.isOther, this.questionId);

  Choice.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    label = json["label"];
    labelAr = json["label_ar"];
    isOther = json["is_other"];
  }

  Map toJson() {
    return {
      'id': id,
      'label': label,
      'label_ar': labelAr,
      'idOther': isOther,
      'questionId': questionId,
    };
  }

  bool operator ==(o) => o is Choice && id == o.id;

  @override
  int get hashCode => id.hashCode;
}
