import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/branched_conditions.dart';
import 'package:collection/collection.dart';
import 'package:rightnow/models/multiselect_answer.dart';

class ConditionDisplay {
  bool precededByLogic(bool v1, int operator, bool v2) {
    return v1 && v2;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  bool isDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  Duration parseDuration(String input, {String separator = ':'}) {
    final parts = input.split(separator).map((t) => t.trim()).toList();

    int? days;
    int? hours;
    int? minutes;
    int? seconds;
    int? milliseconds;
    int? microseconds;

    for (String part in parts) {
      final match = RegExp(r'^(\d+)(d|h|m|s|ms|us])$').matchAsPrefix(part);
      if (match == null) throw FormatException('Invalid duration format');

      int value = int.parse(match.group(1)!);
      String unit = match.group(2)!;

      switch (unit) {
        case 'd':
          if (days != null) {
            throw FormatException('Days specified multiple times');
          }
          days = value;
          break;
        case 'h':
          if (hours != null) {
            throw FormatException('Days specified multiple times');
          }
          hours = value;
          break;
        case 'm':
          if (minutes != null) {
            throw FormatException('Days specified multiple times');
          }
          minutes = value;
          break;
        case 's':
          if (seconds != null) {
            throw FormatException('Days specified multiple times');
          }
          seconds = value;
          break;
        case 'ms':
          if (milliseconds != null) {
            throw FormatException('Days specified multiple times');
          }
          milliseconds = value;
          break;
        case 'us':
          if (microseconds != null) {
            throw FormatException('Days specified multiple times');
          }
          microseconds = value;
          break;
        default:
          throw FormatException('Invalid duration unit $unit');
      }
    }
    return Duration(days: days ?? 0, hours: hours ?? 0, minutes: minutes ?? 0, seconds: seconds ?? 0, milliseconds: milliseconds ?? 0, microseconds: microseconds ?? 0);
  }

  bool _setFloatOrInteger(String selectedValue, Question question, BranchedConditions bc) {
    if (isNumeric(selectedValue) && isNumeric(bc.value!))
      switch (bc.conditionName) {
        case BRANCH_CONDITION_EQUAL_TO:
          return (double.parse(selectedValue) == double.parse(bc.value!));
        case BRANCH_CONDITION_NOT_EQUAL_TO:
          return (double.parse(selectedValue) != double.parse(bc.value!));
        case BRANCH_CONDITION_GREATER_THAN:
          return (double.parse(selectedValue) > double.parse(bc.value!));
        case BRANCH_CONDITION_LESS_THAN:
          return (double.parse(selectedValue) < double.parse(bc.value!));
        default:
          return false;
      }
    return false;
  }

  bool _setDate(String selectedValue, Question question, BranchedConditions bc) {
    if (isDate(selectedValue) && isDate(bc.value!)) {
      DateTime dt_c = DateTime.parse(selectedValue);
      DateTime dt_r = DateTime.parse(bc.value!);
      switch (bc.conditionName) {
        case BRANCH_CONDITION_EQUAL_TO:
          return dt_c.compareTo(dt_r) == 0;
        case BRANCH_CONDITION_NOT_EQUAL_TO:
          return dt_c.compareTo(dt_r) != 0;
        case BRANCH_CONDITION_GREATER_THAN:
          return dt_c.compareTo(dt_r) > 0;
        case BRANCH_CONDITION_LESS_THAN:
          return dt_c.compareTo(dt_r) < 0;
        default:
          return false;
      }
    }
    return false;
  }

  bool _setTime(String selectedValue, Question question, BranchedConditions bc) {
    Duration d1 = parseDuration(selectedValue);
    Duration d2 = parseDuration(bc.value!);
    switch (bc.conditionName) {
      case BRANCH_CONDITION_EQUAL_TO:
        return d1 == d2;
      case BRANCH_CONDITION_NOT_EQUAL_TO:
        return d1 != d2;
      case BRANCH_CONDITION_GREATER_THAN:
        return d1 > d2;
      case BRANCH_CONDITION_LESS_THAN:
        return d2 < d2;
      default:
        return false;
    }
  }

  ConditionDisplay.branchedConditions(Question question, String selectedValue, List<MultiSelectAnswer>? selectedMultiChoices, Function(int depandentQuestionId, bool visibility) visibility) {
    print('branched condtions check');
    if (question.branchedConditions != null) {
      print('branched condtions are not null ' + question.id.toString() + ", " + question.branchedConditions!.length.toString());
      loop:
      for (BranchedConditions bc in question.branchedConditions!) {
        print('branched conditions loop start ' + question.branchedConditions!.length.toString());
        switch (question.resourcetype) {
          case BOOLEAN_QUESTION:
            print("updating visibility of view " + question.id.toString() + ', ' + bc.value! + ", " + selectedValue);
            visibility(bc.dependantQuestion!, (bc.value == selectedValue));
            break;
          case FLOAT_QUESTION:
            visibility(bc.dependantQuestion!, _setFloatOrInteger(selectedValue, question, bc));
            break;
          case INTEGER_QUESTION:
            visibility(bc.dependantQuestion!, _setFloatOrInteger(selectedValue, question, bc));
            break;
          case DATE_QUESTION:
            visibility(bc.dependantQuestion!, _setDate(selectedValue, question, bc));
            break;
          case TIME_QUESTION:
            visibility(bc.dependantQuestion!, _setTime(selectedValue, question, bc));
            break;
          case SELECT_QUESTION:
            print("select question checking for containence 0 ${selectedMultiChoices?.length}");
            print("select question checking for containence 1 " + bc.toJson().toString());
            if (selectedMultiChoices != null) {
              print("select question checking for containence 2");
              bool b = false;
              if (bc.conditionName == BRANCH_CONDITION_CHOICES_CONTAINS) {
                print("select question checking for containence 3 $selectedMultiChoices");
                List<int> bls = [];
                for (var selectedChoice in selectedMultiChoices) {
                  print("select question checking for containence x ${selectedChoice.selectedId}");
                  for (int choice in bc.choices ?? []) {
                    print("select question checking for containence xy ${selectedChoice.selectedId} == $choice");
                    if (choice == selectedChoice.selectedId) {
                      print("select question checking for containence xy equal");
                      bls.add(choice);
                      break;
                    }
                  }
                }
                b = IterableEquality().equals(bls, selectedMultiChoices.map((e) => e.selectedId).toList());
                print("select question checking is visible $b");
              } else {
                print("select question checking for containence 4");
                for (var selectedChoice in selectedMultiChoices) {
                  for (var choice in question.choices ?? []) {
                    if (choice.id == selectedChoice.selectedId) {
                      b = true;
                      break;
                    }
                  }
                }
              }
              visibility(bc.dependantQuestion!, b);
              if (b) break loop;
            }
            break;
          default:
        }
      }
    }
  }

  /*ConditionDisplay.branchedConditions(Question question, String selectedValue, List<int> selectedChoices, Function(int depandentQuestionId, bool visibility) visibility) {
    if (question.branchedConditions != null) {
      print('branched condtions are not null ' + question.id.toString() + ", " + question.branchedConditions!.length.toString());
      for (var bc in question.branchedConditions!) {
        print('branched conditions loop start ' + question.branchedConditions!.length.toString());
        switch (question.resourcetype) {
          case BOOLEAN_QUESTION:
            print("updating visibility of view " + question.id.toString() + ', ' + bc.value! + ", " + selectedValue);
            visibility(bc.dependantQuestion!, (bc.value == selectedValue));
            break;
          case FLOAT_QUESTION:
            visibility(bc.dependantQuestion!, _setFloatOrInteger(selectedValue, question, bc));
            break;
          case INTEGER_QUESTION:
            visibility(bc.dependantQuestion!, _setFloatOrInteger(selectedValue, question, bc));
            break;
          case DATE_QUESTION:
            visibility(bc.dependantQuestion!, _setDate(selectedValue, question, bc));
            break;
          case TIME_QUESTION:
            visibility(bc.dependantQuestion!, _setTime(selectedValue, question, bc));
            break;
          case SELECT_QUESTION:
            if (bc.choices != null) {
              bool b = false;
              if (bc.conditionName == BRANCH_CONDITION_CHOICES_CONTAINS) {
                b = IterableEquality().equals(bc.choices, selectedChoices);
              } else {
                for (var item in selectedChoices) {
                  if (bc.choices!.contains(item)) {
                    b = true;
                    break;
                  }
                }
              }
              visibility(bc.dependantQuestion!, b);
            }
            break;
          default:
        }
      }
    }
  }*/

  ConditionDisplay.branchedLinks(Question question, String selectedValue, List<int> selectedChoices, Function(Question question, bool visibility) visibility) {
    if (question.branchedLinks != null) {
      if (question.branchedLinks!.length > 0) {
        for (var bl in question.branchedLinks!) {
          //View v = list_questions.findViewWithTag(bl.getDependant_question());
          //Log.d("QuestionRecycler", "branched links changing visibility of " + question.getId());
          if (bl.condition == BRANCH_CONDITION_EMPTY) {
            visibility(question, selectedValue.isEmpty);
          } else {
            visibility(question, selectedValue.isNotEmpty);
          }
        }
      }
    }
  }
}
