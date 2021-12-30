import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/rest/ApiRepository.dart';

class TakePictureWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool imageOnly;

  const TakePictureWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.imageOnly,
  }) : super(key: key);
  @override
  _TakePictureWidgetState createState() => _TakePictureWidgetState(this.question, this.onSelectedValue, this.answerHolder);
}

class _TakePictureWidgetState extends State<TakePictureWidget> with AutomaticKeepAliveClientMixin {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  double progress = 0;

  int imageState = 0;

  @override
  void initState() {
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (var answer in answerHolder!.answers!) {
            if (answer.qustionId == question!.id) {
              //fieldDataController.text = answer.answerValue;
              //if (answer.answerValue == null) break;
              setState(() {
                imageState = (answer.answerValue?.isNotEmpty ?? false) ? 1 : 0;
                if (answer.valueExtra != null) if (answer.valueExtra?.isNotEmpty ?? false) _image = File(answer.valueExtra!);
              });
            }
          }
        }
      }
    }
    super.initState();
  }

  File? _image;
  final picker = ImagePicker();

  _TakePictureWidgetState(this.question, this.onSelectedValue, this.answerHolder);

  String _getPictureFilename() {
    return PICTURE_FILENAME + (widget.answerHolder?.id?.toString() ?? "0");
  }

  Future getImage(FormFieldState<int> state) async {
    progress = 0;
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      if (_image != null) {
        String? fPath = await saveFile(_image!, _getPictureFilename());
        if (fPath != null) {
          int s = (await _image!.length());
          double fileSize = s / 1000;

          print("image size is $s, $fileSize");

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
            //imageState = 2;
            imageState = 1;
          });

          onSelectedValue!(
            Answer.fill(question!.id, question!.fieldSet, "", fPath, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!), answerHolder?.id, null),
          );
        }
      }
    }
    state.didChange(imageState);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetQuestionTitle(question!, context.locale.languageCode),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: showWidget(
                _image != null
                    ? Image.file(
                        _image!,
                        width: 200,
                        height: 180,
                      )
                    : Container(),
                Container(),
                _image != null),
          ),
          if (!widget.imageOnly)
            FormField<int>(
              autovalidateMode: AutovalidateMode.always,
              initialValue: imageState,
              builder: (FormFieldState<int> state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    showWidget(
                        SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            icon: showWidget(Icon(Icons.add_a_photo), imageState == -1 ? Icon(Icons.error_outline, color: Colors.red) : Icon(Icons.check, color: Colors.green), imageState == 0),
                            label: Flexible(
                              child: Text(_image != null ? (imageState != -1 ? "Prendre une nouvelle Photo".tr() : "Error uploading picture".tr()) : "Prendre une Photo".tr()),
                            ),
                            onPressed: () {
                              getImage(state);
                            },
                          ),
                        ),
                        _setProgressBar(),
                        (imageState == 0 || imageState == 1 || imageState == -1)),
                    state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                  ],
                );
              },
              validator: (value) {
                if (isRequired(widget.question)) {
                  if (value != 1) {
                    if (value == -1)
                      return FORM_SELECT_PICTURE_NOT_UPLOADED;
                    else if (value == 3)
                      return FORM_SELECT_FILE_GRETAER + (widget.question?.maxSizeKb ?? 0).toString() + " Kb";
                    else if (value == 4) return FORM_SELECT_FILE_LESS + (widget.question?.minSizeKb ?? 0).toString() + " Kb";
                    return FORM_SELECT_PICTURE;
                  }
                } else {
                  if (value == -1)
                    return FORM_SELECT_PICTURE_NOT_UPLOADED;
                  else if (value == 3)
                    return FORM_SELECT_FILE_GRETAER + (widget.question?.maxSizeKb ?? 0).toString() + " Kb";
                  else if (value == 4) return FORM_SELECT_FILE_LESS + (widget.question?.minSizeKb ?? 0).toString() + " Kb";
                }
                return null;
              },
            )
        ],
      ),
    );
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

  @override
  bool get wantKeepAlive => true;
}
