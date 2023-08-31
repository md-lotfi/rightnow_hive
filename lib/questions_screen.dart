import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FieldSetsDao.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/views/multi_select_view.dart';
import 'package:rightnow/views/scanner_view.dart';
import 'package:rightnow/views/signature_view.dart';
import 'package:rightnow/views/sound_view.dart';
import 'package:rightnow/views/sound_web_view.dart';
import 'package:uuid/uuid.dart';

import 'package:rightnow/blocs/questions_bloc.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/QuestionsEvent.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:rightnow/views/boolean_view.dart';
import 'package:rightnow/views/checkbox_view.dart';
import 'package:rightnow/views/conditional_display.dart';
import 'package:rightnow/views/date_view.dart';
import 'package:rightnow/views/decimal_view.dart';
import 'package:rightnow/views/email_view.dart';
import 'package:rightnow/views/file_view.dart';
import 'package:rightnow/views/free_text_view.dart';
import 'package:rightnow/views/geo_view.dart';
import 'package:rightnow/views/integer_view.dart';
import 'package:rightnow/views/phone_view.dart';
import 'package:rightnow/views/radiobox_view.dart';
import 'package:rightnow/views/select_view.dart';
import 'package:rightnow/views/short_text_view.dart';
import 'package:rightnow/views/take_picture_view.dart';
import 'package:rightnow/views/time_view.dart';

class RefreshProgress extends ChangeNotifier {
  void updateProgress() {
    notifyListeners();
  }
}

class QuestionsPage extends StatefulWidget {
  final FieldSet fieldSet;
  final bool anonymous;

  final List<int>? errorQuestions;

  const QuestionsPage({
    Key? key,
    required this.fieldSet,
    required this.anonymous,
    this.errorQuestions,
  }) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final _formKey = GlobalKey<FormState>();
  AnswerHolder? _answerHolder;

  List<Question>? questions;

  Map<int, bool> viewState = {};

  bool _newAnswer = false;

  ValueNotifier<int> _refreshProgress = ValueNotifier<int>(0);

  _QuestionsPageState();

  //bool _hasValidAnswerHolder = false;

  @override
  void initState() {
    //_refreshProgress = ValueNotifier<int>(0);
    _refreshProgress.value = 0;
    getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(widget.fieldSet.form!, HOLDER_NOT_COMPLETED).then((AnswerHolder? value) {
      if (value == null) {
        print("new answer holder");
        _answerHolder = AnswerHolder.fill(
          widget.fieldSet.form,
          false,
          false,
          widget.fieldSet.getName(context.locale.languageCode),
          null,
          DateTime.now().toString(),
          Uuid().v1(),
          LOCAL_ARCHIVED,
        );
        getDataBase<AnswerHolderDao>().insertAnswerHolder(_answerHolder!).then((int answerHolderId) {
          _answerHolder!.id = answerHolderId;
          _newAnswer = true;
          BlocProvider.of<QuestionsBloc>(context).add(QuestionsEvent.loadQuestions(widget.fieldSet.id!));
        });
      } else {
        print("we already have an answer holder ${value.id}, ${value.answers?.length}, ${widget.fieldSet.id}");
        _newAnswer = false;
        _answerHolder = value;
        BlocProvider.of<QuestionsBloc>(context).add(QuestionsEvent.loadQuestions(widget.fieldSet.id!));
      }
      //_refreshProgress.value = _refreshProgress.value++;
    });
    super.initState();
  }

  Future<void> _checkForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool missing = false;
      if (questions != null) {
        for (var q in questions!) {
          if (isRequiredForValidate(q)) {
            var containsAnswer = _answerHolder?.answers?.where((element) {
                  return element.qustionId == q.id;
                }) ??
                [];
            if (containsAnswer.isEmpty) {
              print("missing answer " + q.id.toString() + ", " + q.resourcetype! + ", " + (q.branchedConditions?.length.toString() ?? "0") + ", " + (q.depandantConditions?.length.toString() ?? "0"));
              missing = true;
              break;
            }
          }
        }
      }
      if (missing) {
        _missingFieldsDialog();
      } else {
        await _confirmSave();
      }
    } else {
      _errorFieldsDialog();
    }
  }

  _missingFieldsDialog() {
    showActionMessage(context, title: "Missing Fields".tr(), messages: [Text("You have some missing fields, please complete before validating.".tr())], positiveBtn: "OK".tr(), whichTaped: (w) async {
      await _onWillPop();
    });
  }

  _errorFieldsDialog() {
    showActionMessage(context,
        title: "Erreur de données de champs".tr(),
        messages: [Text("Vous avez quelques champs contenant des erreurs, veuillez vérifier vos données avant de valider".tr())],
        positiveBtn: "OK".tr(), whichTaped: (w) async {
      await _onWillPop();
    });
  }

  /*bool _hasSoundQuestions() {
    for (Answer answer in _answerHolder?.answers ?? []) {
      if (answer.resourcetype == SOUND_RESPONSE) {
        return true;
      }
    }
    return false;
  }*/

  Future<void> _confirmSave() async {
    if (_answerHolder != null) {
      print("saving answer holder " + _answerHolder!.toJson().toString());

      await getDataBase<AnswerHolderDao>().setAnswers(_answerHolder!);
      await getDataBase<FieldSetsDao>().setAnsweredCounts(widget.fieldSet.id!, _answerHolder?.answers?.length ?? 0);
    }
    Navigator.pop(context);
    BlocProvider.of<QuestionsBloc>(context).add(QuestionsEvent.distract());
  }

  Future<bool> _onWillPop() async {
    //if (_hasValidAnswerHolder) return true;
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Quitter le formulaire?".tr()),
            content: Text("Voulez-vous quitter le formulaire? Vous risquez de perdre les données.".tr()),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  //await getDataBase().answerHolderDao.deleteUnclosedAnswerHolder(widget.fieldSet.form!);
                  await _confirmSave();
                  //BlocProvider.of<QuestionsBloc>(context).add(QuestionsEvent.distract());
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  'Quitter'.tr(),
                  style: TextStyle(color: COLOR_PRIMARY),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Continuer'.tr()),
              ),
            ],
          ),
        )) ??
        false;
  }

  int _countVisibleQuestion(FieldSet fieldSet) {
    int i = 0;
    for (Question item in fieldSet.questions ?? []) {
      if (isActive(item)) {
        if (viewState.containsKey(item.id)) {
          if ((viewState[item.id] ?? false) == false) continue;
        }
        if (item.depandantConditions != null) if (item.depandantConditions!.length > 0) {
          continue;
        }
        i++;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: WillPopScope(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: COLOR_PRIMARY,
            title: Text(widget.fieldSet.getName(context.locale.languageCode)),
            actions: [
              if (widget.anonymous) Image.asset("assets/anonymous.png", width: 25),
            ],
          ),
          bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
          body: Column(
            children: [
              ValueListenableBuilder<int>(
                  valueListenable: _refreshProgress,
                  builder: (context, value, child) {
                    int totalQuestions = _countVisibleQuestion(widget.fieldSet); //widget.fieldSet.questionsCount ?? 0;
                    print("total questions are $totalQuestions");
                    double progress = (_answerHolder?.answers
                            ?.where((el) {
                              return el.fieldSetId == widget.fieldSet.id;
                            })
                            .toList()
                            .length
                            .toDouble() ??
                        0);
                    return LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      color: totalQuestions == 0
                          ? Colors.grey
                          : ((progress / totalQuestions) != 1 ? ((progress / totalQuestions) > 0.5 && (progress / totalQuestions) < 1 ? Colors.amber : Colors.red) : Colors.green),
                      value: totalQuestions == 0 ? 0 : (progress / totalQuestions),
                    );
                    //return Container();
                  }),
              Expanded(
                child: _addBuilder(),
              ),
            ],
          )),
      onWillPop: () => _onWillPop(),
    ));
  }

  Widget _addBuilder() {
    return BlocBuilder<QuestionsBloc, ResultState<List<Question>>>(
      builder: (BuildContext context, ResultState<List<Question>> state) {
        return state.when(
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
          idle: () {
            return Container();
          },
          data: (List<Question>? data) {
            //print("received data questions ${data!.map((e) => e.label).toList()}");
            if (data != null) {
              questions = data;
              if (_newAnswer) {
                /*for (var i = 0; i < questions!.length; i++) {
                  _answerHolder!.answers![i] = ;
                  /*print("replace: answers are not null trying to find .... " + answer.qustionId.toString() + ", " + _answerHolder!.answers![i].qustionId.toString());
                if (answer.qustionId == _answerHolder!.answers![i].qustionId) {
                  //_answerHolder.answers.removeAt(i);
                  _answerHolder!.answers![i] = answer;
                  print("replace: answer found replacing current " + i.toString());
                  return;
                }*/
                }*/
              }
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 80,
                    child: RawScrollbar(
                      isAlwaysShown: true,
                      thumbColor: COLOR_PRIMARY,
                      child: Form(
                        key: _formKey,
                        child: ScrollTouchWidget(listChild: dataWidget(data)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: TextButton(
                      onPressed: () async {
                        await _checkForm();
                        //Navigator.of(context).pop(true);
                      },
                      child: Text("Valider".tr()),
                    ),
                  ),
                ],
              );
            }
            return Container();
            /*for (var item in data) {
                print("questions data received " + item.resourcetype);
              }*/
          },
          error: (NetworkExceptions? error) {
            return Text(NetworkExceptions.getErrorMessage(error!));
          },
        );
      },
    );
  }

  void _replaceAnswerIfExists(Question question, Answer answer) {
    print("value notifier value ${_refreshProgress.value}");
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _refreshProgress.value = _refreshProgress.value++;
    });
    /*SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (viewState[question.id]!) _refreshProgress.value = _refreshProgress.value++;
    });*/
    print("replace question is " + (question.toJson().toString()));
    ConditionDisplay.branchedConditions(question, answer.answerValue!, answer.multiSelectAnswer, (q, v) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          print("conditional branched recieved state " + q.toString() + ", " + v.toString());
          viewState[q] = v;
        });
      });
    });
    if (_answerHolder != null) {
      if (_answerHolder!.answers == null) {
        print("replace: answers are null, creating new ....");
        _answerHolder!.answers = [];
        _answerHolder!.answers!.add(answer);
        return;
      }
      for (var i = 0; i < _answerHolder!.answers!.length; i++) {
        print("replace: answers are not null trying to find ....${_answerHolder!.answers} " + answer.qustionId.toString() + ", " + _answerHolder!.answers![i].qustionId.toString());
        if (answer.qustionId == _answerHolder!.answers![i].qustionId) {
          //_answerHolder.answers.removeAt(i);
          _answerHolder!.answers![i] = answer;
          print("replace: answer found replacing current ${_answerHolder!.answers?[i].answerValue} " + i.toString());
          return;
        }
      }
      print("answer add is " + answer.resourcetype! + ", " + answer.answerHolderId.toString());
      _answerHolder!.answers!.add(answer);
    }
  }

  bool _initViewVisibility(Question q) {
    if (!isActive(q)) return false;
    //if (widget.errorQuestions?.contains(q.id) == true) return true;
    print("checking question visibility " + q.id.toString() + ", " + ((q.depandantConditions != null).toString()));
    if (q.depandantConditions != null) if (q.depandantConditions!.length > 0) {
      print("checking question question has depandant questions " + q.depandantConditions!.length.toString());
      return false;
    }
    return true;
  }

  /*Widget _test(List<Question> questions) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        Question q = questions[index];
        if (q.resourcetype == SELECT_QUESTION)
          return MultiSelectView(
            key: Key('__RIKEY__' + q.id!.toString()),
            viewOnly: false,
            answerHolder: _answerHolder,
            onSelectedValue: (Answer answer) {
              _replaceAnswerIfExists(q, answer);
            },
            question: q,
          );
        return Container();
      },
    );
  }*/

  Widget dataWidget(List<Question> questions) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        Question q = questions[index];
        print("setting question view " + q.id.toString());
        if (viewState[q.id] == null) {
          //print("setting question visisbility first time " + q.id.toString());
          viewState[q.id!] = _initViewVisibility(q);
          print("setting question visisbility AAAA ${q.id} as state ${viewState[q.id!]}");
        } else
          print("quetion state " + Jiffy(q.createdAt).jms);
        switch (q.resourcetype) {
          case SCANNER_QUESTION:
            return Visibility(
              child: ScannerWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case SOUND_QUESTION:
            if (!kIsWeb) {
              return Visibility(
                child: SoundView(
                  key: Key('__RIKEY__' + q.id!.toString()),
                  viewOnly: false,
                  answerHolder: _answerHolder,
                  onSelectedValue: (Answer answer) {
                    _replaceAnswerIfExists(q, answer);
                  },
                  question: q,
                ),
                visible: viewState[q.id]!,
              );
            } else {
              return Visibility(
                child: SoundWebView(
                  key: Key('__RIKEY__' + q.id!.toString()),
                  viewOnly: false,
                  answerHolder: _answerHolder,
                  onSelectedValue: (Answer answer) {
                    _replaceAnswerIfExists(q, answer);
                  },
                  question: q,
                ),
                visible: viewState[q.id]!,
              );
            }
          case SIGNATURE_QUESTION:
            return Visibility(
              child: SignatureView(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case SHORT_TEXT_QUESTION:
            return Visibility(
              child: ShortTextWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case BOOLEAN_QUESTION:
            return Visibility(
              child: BooleanWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case EMAIL_QUESTION:
            return Visibility(
              child: EmailWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case FREE_TEXT_QUESTION:
            return Visibility(
              child: FreeTextWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case FLOAT_QUESTION:
            return Visibility(
              child: DecimalWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case INTEGER_QUESTION:
            return Visibility(
              child: IntegerWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case DATE_QUESTION:
            return Visibility(
              child: DateWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  log("date widget answer value is ${answer.answerValue}");
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case FILE_QUESTION:
            //print("showing file or ")
            //print("question view state is in file " + viewState[q.id].toString() + ", " + q.id.toString());
            if (q.type == '1') {
              return Visibility(
                visible: viewState[questions[index].id]!,
                child: FileWidget(
                  key: Key('__RIKEY__' + q.id!.toString()),
                  viewOnly: false,
                  answerHolder: _answerHolder,
                  onSelectedValue: (Answer answer) {
                    _replaceAnswerIfExists(q, answer);
                  },
                  question: q,
                ),
              );
            } else {
              print("setting question visisbility fot ${q.id} as state ${viewState[q.id!]}");
              return Visibility(
                visible: viewState[q.id]!,
                child: TakePictureWidget(
                  key: Key('__RIKEY__' + q.id!.toString()),
                  answerHolder: _answerHolder,
                  imageOnly: false,
                  onSelectedValue: (Answer answer) {
                    _replaceAnswerIfExists(q, answer);
                  },
                  question: q,
                ),
              );
            }
          case SELECT_QUESTION:
            switch (q.type) {
              case CHECKBOX_MULTIPLE_CHOICE:
                return Visibility(
                  child: CheckboxWidget(
                    key: Key('__RIKEY__' + q.id!.toString()),
                    viewOnly: false,
                    answerHolder: _answerHolder,
                    onSelectedValue: (Answer answer) {
                      _replaceAnswerIfExists(q, answer);
                    },
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
              case CHECKBOX_UNIQUE_CHOICE:
                return Visibility(
                  child: RadioboxWidget(
                    key: Key('__RIKEY__' + q.id!.toString()),
                    viewOnly: false,
                    answerHolder: _answerHolder,
                    onSelectedValue: (Answer answer) {
                      _replaceAnswerIfExists(q, answer);
                    },
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
              case DROPDOWN_UNIQUE_CHOICE:
                print("select widget " + viewState[questions[index].id].toString());
                return Visibility(
                  child: SelectWidget(
                    key: Key('__RIKEY__' + q.id!.toString()),
                    viewOnly: false,
                    answerHolder: _answerHolder,
                    onSelectedValue: (Answer answer) {
                      _replaceAnswerIfExists(q, answer);
                    },
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
              case DROPDOWN_MULTIPLE_CHOICE:
                print("select widget " + viewState[questions[index].id].toString());
                return Visibility(
                  child: MultiSelectView(
                    key: Key('__RIKEY__' + q.id!.toString()),
                    viewOnly: false,
                    answerHolder: _answerHolder,
                    onSelectedValue: (Answer answer) {
                      _replaceAnswerIfExists(q, answer);
                    },
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
              default:
                return Container(
                  child: Text("Select Not implemented: " + q.getName(context.locale.languageCode)),
                );
            }
          case GEO_QUESTION:
            return Visibility(
              child: GeoWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case PHONE_QUESTION:
            return Visibility(
              child: PhoneWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case TIME_QUESTION:
            return Visibility(
              child: TimeWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: false,
                answerHolder: _answerHolder,
                onSelectedValue: (Answer answer) {
                  _replaceAnswerIfExists(q, answer);
                },
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          default:
            return Container(
              child: Text("Not implemented: " + q.getName(context.locale.languageCode)),
            );
        }
      },
    );
  }
}
