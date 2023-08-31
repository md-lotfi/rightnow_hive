import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/file_saver.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:rightnow/models/response_set.dart';
import 'package:rightnow/views/google_maps_screen.dart';

class GeoWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final ResponseSet? responseSet;
  final bool viewOnly;

  const GeoWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _GeoWidgetState createState() => _GeoWidgetState(this.question, this.onSelectedValue, this.answerHolder);
}

class _GeoWidgetState extends State<GeoWidget> with AutomaticKeepAliveClientMixin {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  Uint8List? _image;
  int geoState = 0;

  Answer? _currentAnswer;

  String? geoValue;
  int? _fileKey;

  @override
  void initState() {
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (var answer in answerHolder!.answers!) {
            if (answer.qustionId == question!.id) {
              if (answer.answerValue == null) break;
              setState(() {
                geoState = answer.answerValue!.isNotEmpty ? 1 : 0;
                geoValue = answer.answerValue ?? "";
                _currentAnswer = answer;
                _fileKey = _currentAnswer?.fileKey;
              });
            }
          }
        }
      }
    }
    super.initState();
  }

  _GeoWidgetState(this.question, this.onSelectedValue, this.answerHolder);

  Future<bool> _setGeo(FormFieldState<int> state) async {
    LatLngImage res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoogleMapsPage(),
      ),
    );
    if (answerHolder != null) {
      _image = res.image;
      //await saveUint8ListFile(_image!, getMapFilename());
      String n = getMapFilename();
      await FileSaver.set(FileSaver(name: n, path: n, file: _image!, questionId: question!.id!, answerHolderId: answerHolder!.id!));
      print("getting image from map ");
      geoState = 1;
      List<MultiSelectAnswer> m = [];
      m.add(MultiSelectAnswer.fillGeo(answerHolder!.id, res.latLng.latitude));
      m.add(MultiSelectAnswer.fillGeo(answerHolder!.id, res.latLng.longitude));
      FileSaver? f = await FileSaver.getLastItem();
      if (f != null) {
        _fileKey = f.key;
        onSelectedValue!(
          Answer.fill(question!.id, question!.fieldSet, (res.latLng.latitude.toString() + GPS_SEPARRATOR + res.latLng.longitude.toString()), null, DateTime.now().toString(),
              transtypeResourceType(question!.resourcetype!), answerHolder!.id, m,
              fileKey: f.key),
        );
      }
      state.didChange(geoState);
      setState(() {});
      return true;
    }
    return false;
  }

  String getMapFilename() {
    return MAP_FILENAME + (widget.answerHolder?.id?.toString() ?? "0") + ".png";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetQuestionTitle(question, context.locale.languageCode, widget.responseSet),
          if (!widget.viewOnly)
            FutureBuilder<FileSaver?>(
              future: FileSaver.getBykey(_fileKey), //getUint8ListFile(getMapFilename()),
              builder: (context, snapshot) {
                if (ConnectionState.done == snapshot.connectionState) {
                  _image = snapshot.data?.file;
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: showWidget(
                        _image != null
                            ? Image.memory(
                                _image!,
                                width: 200,
                                height: 180,
                              )
                            : Container(),
                        Container(),
                        _image != null),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          if (!widget.viewOnly)
            FormField<int>(
              autovalidateMode: AutovalidateMode.always,
              initialValue: geoState,
              builder: (FormFieldState<int> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showWidget(
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          icon: showWidget(Icon(Icons.map), Icon(Icons.check, color: Colors.green), geoState == 0),
                          label: Text("Prendre ma position".tr()),
                          onPressed: () async {
                            await _setGeo(state);
                          },
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                      (geoState == 0 || geoState == 1),
                    ),
                    state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                  ],
                );
              },
              validator: (value) {
                if (isRequired(question)) if (geoState == 0) return FORM_SELECT_GPS;
                return null;
              },
            ),
          if (widget.viewOnly && widget.responseSet != null)
            FutureBuilder<FileSaver?>(
              future: FileSaver.getBykey(_fileKey),
              builder: (context, snapshot) {
                if (ConnectionState.done == snapshot.connectionState) {
                  _image = snapshot.data?.file;
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: showWidget(
                        _image != null
                            ? Image.network(
                                widget.responseSet!.value ?? "",
                                width: 200,
                                height: 180,
                              )
                            : Container(),
                        Container(),
                        _image != null),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          //fieldData(geoValue),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LatLngImage {
  final Uint8List image;
  final LatLng latLng;

  LatLngImage(this.image, this.latLng);
}
