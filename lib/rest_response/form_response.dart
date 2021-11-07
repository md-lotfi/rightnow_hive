import 'package:rightnow/models/FormFields.dart';

class FormsResponse {
  List<FormFields> forms = [];

  FormsResponse.fromJson(List<dynamic> json) {
    if (json != null) {
      for (var data in json) forms.add(FormFields.fromJson(data));
    }
  }
}
