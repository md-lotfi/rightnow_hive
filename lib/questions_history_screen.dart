import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/blocs/questions_bloc.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/QuestionsEvent.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/models/response_entry.dart';
import 'package:rightnow/models/response_form.dart';
import 'package:rightnow/models/response_set.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:rightnow/views/boolean_view.dart';
import 'package:rightnow/views/checkbox_view.dart';
import 'package:rightnow/views/multi_select_view.dart';
import 'package:rightnow/views/date_view.dart';
import 'package:rightnow/views/decimal_view.dart';
import 'package:rightnow/views/email_view.dart';
import 'package:rightnow/views/file_view.dart';
import 'package:rightnow/views/free_text_view.dart';
import 'package:rightnow/views/geo_view.dart';
import 'package:rightnow/views/integer_view.dart';
import 'package:rightnow/views/phone_view.dart';
import 'package:rightnow/views/radiobox_view.dart';
import 'package:rightnow/views/scanner_view.dart';
import 'package:rightnow/views/select_view.dart';
import 'package:rightnow/views/short_text_view.dart';
import 'package:rightnow/views/signature_view.dart';
import 'package:rightnow/views/sound_view.dart';
import 'package:rightnow/views/take_picture_view.dart';
import 'package:rightnow/views/time_view.dart';
import 'package:uuid/uuid.dart';

class QuestionsHistoryPage extends StatefulWidget {
  //final List<Answer> answers;
  //final FieldSet fieldSet;
  //final AnswerHolder answerHolder;
  //final String deviceId;
  final Reclamations reclamations;

  const QuestionsHistoryPage({
    Key? key,
    required this.reclamations,
  }) : super(key: key);

  @override
  _QuestionsHistoryPageState createState() => _QuestionsHistoryPageState();
}

class _QuestionsHistoryPageState extends State<QuestionsHistoryPage> {
  List<Question>? questions;

  Map<int, bool> viewState = {};

  ApiRepository api = ApiRepository();

  @override
  void initState() {
    //BlocProvider.of<QuestionsBloc>(context).add(QuestionsEvent.loadQuestions(widget.fieldSet.id ?? -1));
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
          title: Text(widget.reclamations.getName(context.locale.languageCode), style: TextStyle(color: COLOR_PRIMARY)), //widget.fieldSet.getName(context.locale.languageCode)
        ),
        bottomNavigationBar: HomeNavBarComp(NavState.NAV_HISTORY),
        body: FutureBuilder<ResponseForm?>(
          future: api.getResponses(widget.reclamations.formEntry?.deviceId ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) return _addBuilder(snapshot.data!);
              return Center(child: Text("An error has occured".tr()));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _addBuilder(ResponseForm responseform) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 80,
          child: RawScrollbar(
            trackVisibility: true,
            thumbColor: COLOR_PRIMARY,
            child: ScrollTouchWidget(listChild: dataWidget(responseform.entries ?? [])),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: TextButton(
            onPressed: () async {
              if (widget.reclamations.deviceId != null) {
                DecisionResponse? r = await api.fetchAlgoResponse(widget.reclamations.deviceId!);
                //print("decision response is ${widget.answerHolder.decisionResponse}");
                showResponseDialog(context, r, () {});
              }
            },
            child: Text("Afficher le résultat".tr()),
          ),
        ),
      ],
    );
  }

  Widget dataWidget(List<ResponseEntry> responseEntries) {
    List<ResponseSet> responseSets = [];
    for (ResponseEntry res in responseEntries) {
      for (ResponseSet item in res.responseSet ?? []) {
        responseSets.add(item);
      }
    }
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: responseSets.length,
      itemBuilder: (BuildContext context, int index) {
        ResponseSet rs = responseSets[index];
        switch (rs.resourcetype) {
          case SCANNER_RESPONSE:
            return ScannerWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case SOUND_RESPONSE:
            return SoundView(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case SIGNATURE_RESPONSE:
            return SignatureView(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case SHORT_TEXT_RESPONSE:
            return ShortTextWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case BOOLEAN_RESPONSE:
            return BooleanWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case EMAIL_RESPONSE:
            return EmailWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case FREE_TEXT_RESPONSE:
            return FreeTextWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case FLOAT_RESPONSE:
            return DecimalWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case INTEGER_RESPONSE:
            return IntegerWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case DATE_RESPONSE:
            return DateWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case FILE_RESPONSE:
            //print("question view state is in file " + viewState[q.id].toString() + ", " + q.id.toString());
            if (rs.type == '1') {
              return FileWidget(
                viewOnly: true,
                onSelectedValue: (Answer answer) {},
                responseSet: rs,
              );
            } else {
              return TakePictureWidget(
                imageOnly: true,
                onSelectedValue: (Answer answer) {},
                responseSet: rs,
              );
            }
          case SELECT_RESPONSE:
            switch (rs.type) {
              case CHECKBOX_MULTIPLE_CHOICE:
                return CheckboxWidget(
                  viewOnly: true,
                  onSelectedValue: (Answer answer) {},
                  responseSet: rs,
                );
              case CHECKBOX_UNIQUE_CHOICE:
                return RadioboxWidget(
                  viewOnly: true,
                  onSelectedValue: (Answer answer) {},
                  responseSet: rs,
                );
              case DROPDOWN_UNIQUE_CHOICE:
                return SelectWidget(
                  viewOnly: true,
                  onSelectedValue: (Answer answer) {},
                  responseSet: rs,
                );
              case DROPDOWN_MULTIPLE_CHOICE:
                return MultiSelectView(
                  viewOnly: true,
                  onSelectedValue: (Answer answer) {},
                  responseSet: rs,
                );
              default:
                return Container(
                  child: Text("Select Not implemented: ${rs.toJson()}, " + (rs.questionHist?.getName(context.locale.languageCode) ?? "")),
                );
            }
          case GEO_RESPONSE:
            return GeoWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case PHONE_RESPONSE:
            return PhoneWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          case TIME_RESPONSE:
            return TimeWidget(
              viewOnly: true,
              onSelectedValue: (Answer answer) {},
              responseSet: rs,
            );
          default:
            Container(
              child: Text(rs.questionHist?.getName(context.locale.languageCode) ?? ""),
            );
        }
        return Container(
          child: Text(rs.questionHist?.getName(context.locale.languageCode) ?? ""),
        );
      },
    );
  }
}
