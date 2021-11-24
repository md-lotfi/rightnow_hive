import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:rightnow/screen_viewer.dart';
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
import 'package:uuid/uuid.dart';

class QuestionsHistoryPage extends StatefulWidget {
  //final List<Answer> answers;
  final FieldSet fieldSet;
  final AnswerHolder answerHolder;

  const QuestionsHistoryPage({
    Key? key,
    required this.fieldSet,
    required this.answerHolder,
  }) : super(key: key);

  @override
  _QuestionsHistoryPageState createState() => _QuestionsHistoryPageState();
}

class _QuestionsHistoryPageState extends State<QuestionsHistoryPage> {
  //AnswerHolder? _answerHolder;

  List<Question>? questions;

  Map<int, bool> viewState = {};

  //bool _hasValidAnswerHolder = false;

  @override
  void initState() {
    BlocProvider.of<QuestionsBloc>(context).add(QuestionsEvent.loadQuestions(widget.fieldSet.id ?? -1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.fieldSet.getName(context.locale.languageCode)),
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX),
      body: _addBuilder(),
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
            print("received data questions ${data?.length}");
            if (data != null) {
              questions = data;
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
                      child: dataWidget(data),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: TextButton(
                      onPressed: () async {
                        print("decision response is ${widget.answerHolder.decisionResponse}");
                        showResponseDialog(context, widget.answerHolder.decisionResponse, () {});
                      },
                      child: Text("Afficher le résultat".tr()),
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

  bool _initViewVisibility(Question q) {
    //if (widget.errorQuestions?.contains(q.id) == true) return true;
    print("checking question visibility " + q.id.toString() + ", " + ((q.depandantConditions != null).toString()));
    if (q.depandantConditions != null) if (q.depandantConditions!.length > 0) {
      print("question has depandant questions " + q.depandantConditions!.length.toString());
      return false;
    }
    return true;
  }

  Widget dataWidget(List<Question> questions) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        Question q = questions[index];
        print("setting question view " + q.id.toString());
        if (viewState[q.id] == null) {
          print("setting question visisbility first time " + q.id.toString());
          viewState[q.id!] = _initViewVisibility(q);
        } else
          print("setting question view state is " + viewState[q.id].toString() + ", " + q.id.toString());
        switch (q.resourcetype) {
          case SHORT_TEXT_QUESTION:
            return Visibility(
              child: ShortTextWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case BOOLEAN_QUESTION:
            return Visibility(
              child: BooleanWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case EMAIL_QUESTION:
            return Visibility(
              child: EmailWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case FREE_TEXT_QUESTION:
            return Visibility(
              child: FreeTextWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case FLOAT_QUESTION:
            return Visibility(
              child: DecimalWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case INTEGER_QUESTION:
            return Visibility(
              child: IntegerWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case DATE_QUESTION:
            return Visibility(
              child: DateWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case FILE_QUESTION:
            //print("question view state is in file " + viewState[q.id].toString() + ", " + q.id.toString());
            if (q.type == '1') {
              return Visibility(
                visible: viewState[questions[index].id]!,
                child: FileWidget(
                  key: Key('__RIKEY__' + q.id!.toString()),
                  viewOnly: true,
                  answerHolder: widget.answerHolder,
                  onSelectedValue: (Answer answer) {},
                  question: q,
                ),
              );
            } else {
              return Visibility(
                visible: viewState[q.id]!,
                child: TakePictureWidget(
                  key: Key('__RIKEY__' + q.id!.toString()),
                  answerHolder: widget.answerHolder,
                  onSelectedValue: (Answer answer) {},
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
                    viewOnly: true,
                    answerHolder: widget.answerHolder,
                    onSelectedValue: (Answer answer) {},
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
              case CHECKBOX_UNIQUE_CHOICE:
                return Visibility(
                  child: RadioboxWidget(
                    key: Key('__RIKEY__' + q.id!.toString()),
                    viewOnly: true,
                    answerHolder: widget.answerHolder,
                    onSelectedValue: (Answer answer) {},
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
              default:
                print("select widget " + viewState[questions[index].id].toString());
                return Visibility(
                  child: SelectWidget(
                    key: Key('__RIKEY__' + q.id!.toString()),
                    viewOnly: true,
                    answerHolder: widget.answerHolder,
                    onSelectedValue: (Answer answer) {},
                    question: q,
                  ),
                  visible: viewState[q.id]!,
                );
            }
          case GEO_QUESTION:
            return Visibility(
              child: GeoWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case PHONE_QUESTION:
            return Visibility(
              child: PhoneWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          case TIME_QUESTION:
            return Visibility(
              child: TimeWidget(
                key: Key('__RIKEY__' + q.id!.toString()),
                viewOnly: true,
                answerHolder: widget.answerHolder,
                onSelectedValue: (Answer answer) {},
                question: q,
              ),
              visible: viewState[q.id]!,
            );
          default:
        }
        return Container(
          child: Text(q.getName(context.locale.languageCode)),
        );
      },
    );
  }
}
