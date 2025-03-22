import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';

class JiffySecondsConverter implements JsonConverter<Jiffy?, String?> {
  const JiffySecondsConverter();

  @override
  Jiffy fromJson(String? json) {
    log("updatedAt before $json");
    if (json == null || json == 'null') return dateParser(null);
    if (json.contains(".")) {
      json = json.substring(0, json.length - 1);
    }
    //print("converting $json to jiffy");
    DateTime tempDate = Intl.withLocale(
        'en',
        () => DateFormat("yyyy-MM-ddTHH:mm:ss")
            .parse(json ?? dateParser(null).dateTime.toIso8601String(), true));
    log("updatedAt after ${tempDate.toIso8601String()}");
    return dateParser(tempDate);
  }

  @override
  String toJson(Jiffy? json) {
    if (json == null) return dateParser(null).dateTime.toIso8601String();
    return json.dateTime.toIso8601String();
  }
}
