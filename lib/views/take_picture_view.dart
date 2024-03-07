import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';

import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/file_saver.dart';
import 'package:rightnow/models/response_set.dart';

class TakePictureWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final ResponseSet? responseSet;
  final bool imageOnly;

  const TakePictureWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
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

  Answer? _currentAnswer;
  int? _fileKey;

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
                if (answer.valueExtra != null) if (answer.valueExtra?.isNotEmpty ?? false) {
                  _currentAnswer = answer;
                  _fileKey = _currentAnswer?.fileKey;
                  imageState = 1;
                }
                /*SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
                    _image = await FileSaver.getImageByAnswerHolder(answer.answerHolderId!);
                  });*/
                //_image = File(answer.valueExtra!);
              });
            }
          }
        }
      }
    }
    super.initState();
  }

  //File? _image;
  Uint8List? _image;
  final picker = ImagePicker();

  _TakePictureWidgetState(this.question, this.onSelectedValue, this.answerHolder);

  String _getPictureFilename() {
    return "PICTURE_FILENAME_${widget.question?.id}_${Jiffy.now().microsecondsSinceEpoch}";
  }

  Future<void> _save(String? fPath, FormFieldState<int> state) async {
    if (fPath != null) {
      int s = _image!.lengthInBytes;
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

      FileSaver? f = await FileSaver.getLastItem();
      if (f != null) {
        _fileKey = f.key;
        onSelectedValue!(
          Answer.fill(question!.id, question!.fieldSet, "", fPath, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!), answerHolder?.id, null, fileKey: f.key),
        );
      }
      setState(() {
        //imageState = 2;
        _image = _image;
        imageState = 1;
      });
    }
  }

  Future getImage(FormFieldState<int> state) async {
    progress = 0;
    log("getting image ....");
    final pickedFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 1080, imageQuality: 75);
    if (pickedFile != null) {
      log("picked file is ....");
      _image = await pickedFile.readAsBytes();
      if (_image != null) {
        String n = _getPictureFilename();
        await FileSaver.set(FileSaver(name: n, path: "", extension: "jpeg", file: _image!, questionId: question!.id!, answerHolderId: answerHolder!.id!));
        await _save(n, state);
        /*if (!kIsWeb) {
        _image = File(pickedFile.path);
        if (_image != null) {
          String? fPath = await saveFile(_image!, _getPictureFilename());
          await _save(fPath, state);
        }
      } else {
        Uint8List f = await pickedFile.readAsBytes();
        await FileSaver.set(FileSaver(name: _getPictureFilename(), file: f));
        await _save(_getPictureFilename(), state);
      }*/
      }
    }
    state.didChange(imageState);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FileSaver?>(
      future: FileSaver.getBykey(_fileKey),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _image = snapshot.data?.file;
          return _setUp(context);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _setUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetQuestionTitle(widget.question, context.locale.languageCode, widget.responseSet),
          if (widget.imageOnly && widget.responseSet != null)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Image.network(
                (widget.responseSet?.url ?? ""), //resoiurce humain, demande de fond
                width: 200,
                height: 180,
              ),
            ),
          if (!widget.imageOnly || (widget.imageOnly && widget.answerHolder != null && widget.responseSet == null))
            Container(
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
                    //Text("image state is $imageState"),
                    if (imageState == 0 || imageState == 1 || imageState == -1)
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          icon: showWidget(Icon(Icons.add_a_photo), imageState == -1 ? Icon(Icons.error_outline, color: Colors.red) : Icon(Icons.check, color: Colors.green), imageState == 0),
                          label: Text(_image != null ? (imageState != -1 ? "Prendre une nouvelle Photo".tr() : "Error uploading picture".tr()) : "Prendre une Photo".tr()),
                          onPressed: () {
                            getImage(state);
                          },
                        ),
                      ),
                    if (imageState != 0 && imageState != 1 && imageState != -1) _setProgressBar(),
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
