import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/inherits/field_controller.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';

class FileWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const FileWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);
  @override
  FileWidgetState createState() => FileWidgetState(this.question, this.answerHolder, this.onSelectedValue);
}

class FileWidgetState extends State<FileWidget> with AutomaticKeepAliveClientMixin {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  String? _file;

  int _fileState = 0;

  double progress = 0;

  ApiRepository apiRepository = ApiRepository();

  FileWidgetState(this.question, this.answerHolder, this.onSelectedValue);
  @override
  Widget build(BuildContext context) {
    return load();
  }

  @override
  void initState() {
    //fieldDataController.addListener(_printLatestValue);
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (Answer answer in answerHolder!.answers!) {
            print("file result is ${answer.qustionId}");
            if (answer.qustionId == question!.id) {
              _file = answer.valueExtra ?? "";
              _fileState = (answer.answerValue?.isNotEmpty ?? false) ? 1 : 0;
              print("file result is $_file, $_fileState");
            }
          }
        }
      }
    }
    super.initState();
    //myController = TextEditingController();
    //myController.addListener(_printLatestValue);
  }

  /*_printLatestValue() {
    print("file changed field: ${fieldDataController.text}");
    onSelectedValue!(
      Answer.fill(question!.id, question!.fieldSet, fieldDataController.text, null, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!), answerHolder!.id, null),
    );
  }*/

  @override
  void dispose() {
    //myController.dispose();
    super.dispose();
  }

  Widget _setProgressBar() {
    return SizedBox(
      height: 65,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
                strokeWidth: 8,
                value: progress,
              ),
            ),
          ),
          Center(
              child: Text(
            "${(progress * 100).round()}%",
          )),
        ],
      ),
    );
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(question!, context.locale.languageCode),
            if (!widget.viewOnly)
              FormField<int>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: _fileState,
                builder: (FormFieldState<int> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_fileState == 1)
                        Center(
                            child: Image.asset(
                          "assets/file.png",
                          width: 100,
                          fit: BoxFit.scaleDown,
                        )),
                      if (_fileState == 1 && _file != null)
                        Center(
                            child: Text(_file!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                      showWidget(
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              icon: showWidget(Icon(Icons.file_upload), _fileState == -1 ? Icon(Icons.error_outline, color: Colors.red) : Icon(Icons.check, color: Colors.green),
                                  _fileState == 0), //Icon(Icons.file_upload),
                              label: Flexible(
                                //child: Text(_controller.isNotEmpty ? (imageState != -1 ? "Reprend une nouvelle Photo".tr() : "Error uploading picture".tr()) : "Prend une Photo".tr()),
                                child: _fileState == 0 ? Text("Charger un fichier".tr()) : Text("Charger un nouveau fichier".tr()),
                              ),
                              onPressed: () async {
                                selectFile().then((result) async {
                                  if (result != null) {
                                    setState(() {
                                      _fileState = 0;
                                      progress = 0;
                                    });
                                    File file = File(result.files.single.path ?? "");

                                    double fileSize = (await file.length()) / 1024;
                                    if (question?.maxSizeKb != null) {
                                      if (fileSize > question!.maxSizeKb!) {
                                        state.didChange(3);
                                        return;
                                      }
                                    }
                                    if (question?.minSizeKb != null) {
                                      if (fileSize < question!.minSizeKb!) {
                                        state.didChange(4);
                                        return;
                                      }
                                    }

                                    setState(() {
                                      _fileState = 2;
                                    });

                                    _file = result.files.single.name;
                                    print("File selected is " + file.path);

                                    Map<String, dynamic> r = await apiRepository.uploadFile(question!, file, (received, total) {
                                      setState(() {
                                        progress = received / total;
                                      });
                                      print("progress $received / $total");
                                    });

                                    if (r['id'] != null) {
                                      _fileState = 1;
                                      onSelectedValue!(
                                        Answer.fill(question!.id, question!.fieldSet, r['id'].toString(), _file, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!),
                                            answerHolder!.id, null),
                                      );
                                    } else
                                      _fileState = -1;
                                    state.didChange(_fileState);
                                  }
                                });
                                setState(() {});
                              },
                            ),
                          ),
                          _setProgressBar(),
                          (_fileState == 0 || _fileState == 1 || _fileState == -1)),
                      state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(widget.question)) {
                    if (value != 1) {
                      if (value == -1)
                        return FORM_SELECT_FILE_NOT_UPLOADED;
                      else if (value == 3)
                        return FORM_SELECT_FILE_GRETAER + (widget.question?.maxSizeKb ?? 0).toString() + " Kb";
                      else if (value == 4) return FORM_SELECT_FILE_LESS + (widget.question?.minSizeKb ?? 0).toString() + " Kb";
                      return FORM_SELECT_FILE;
                    }
                  } else {
                    if (value == -1)
                      return FORM_SELECT_FILE_NOT_UPLOADED;
                    else if (value == 3)
                      return FORM_SELECT_FILE_GRETAER + (widget.question?.maxSizeKb ?? 0).toString() + " Kb";
                    else if (value == 4) return FORM_SELECT_FILE_LESS + (widget.question?.minSizeKb ?? 0).toString() + " Kb";
                  }
                  return null;
                },
              ),
            if (widget.viewOnly) fieldData(_file),
            Divider(),
          ],
        ),
      ),
    );
  }

  Future<FilePickerResult?> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result;
  }

  @override
  bool get wantKeepAlive => true;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
