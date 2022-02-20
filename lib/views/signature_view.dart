import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/signature_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/file_saver.dart';

class SignatureView extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;
  const SignatureView({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> with AutomaticKeepAliveClientMixin {
  double progress = 0;
  int imageState = 0;

  Uint8List? _image;

  int? _fileKey;

  @override
  void initState() {
    if (widget.answerHolder != null) {
      if (widget.answerHolder!.answers != null) {
        if (widget.answerHolder!.answers!.length > 0) {
          for (var answer in widget.answerHolder!.answers!) {
            log("has answer ${answer.qustionId}, ${widget.question!.id}");
            if (answer.qustionId == widget.question!.id) {
              log("has answer after ${answer.answerValue}");
              imageState = (answer.answerValue?.isNotEmpty ?? false) ? 1 : 0;
              _fileKey = answer.fileKey;
            }
          }
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load();
  }

  String getSignatureFilename() {
    return SIGNATURE_FILENAME + (widget.answerHolder?.id?.toString() ?? "0") + SIGNATURE_FILENAME_EXT;
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(widget.question!, context.locale.languageCode),
            //if (!widget.viewOnly)
            FutureBuilder<FileSaver?>(
              future: FileSaver.getBykey(_fileKey), //getUint8ListFile(getSignatureFilename()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  log("checking image exists ?? $imageState");
                  if (imageState == 1) {
                    _image = snapshot.data?.file; //snapshot.data;
                  }

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
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            if (!widget.viewOnly)
              FormField<int>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: imageState,
                builder: (FormFieldState<int> state) {
                  return Column(
                    children: [
                      showWidget(
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              icon: showWidget(
                                  Image.asset(
                                    "assets/signature.png",
                                    width: 20,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  imageState == -1
                                      ? Icon(Icons.error_outline, color: Colors.red)
                                      : Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                  imageState == 0),
                              label: Text("Ajouter une signature".tr()),
                              /*Flexible(
                                //child: Text(_controller.isNotEmpty ? (imageState != -1 ? "Reprend une nouvelle Photo".tr() : "Error uploading picture".tr()) : "Prend une Photo".tr()),
                                child: Text("Ajouter une signature".tr()),
                              ),*/
                              onPressed: () async {
                                //getImage();
                                _image = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignatureWidget(),
                                  ),
                                );
                                SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                                  _setSignature(state);
                                });
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
                  if (isRequired(widget.question)) if (value != 1) {
                    if (value == -1) return FORM_SELECT_FILE_NOT_UPLOADED;
                    return FORM_SELECT_FILE;
                  }
                  return null;
                },
              ),
            //if (widget.viewOnly) fieldData(""),
          ],
        ),
      ),
    );
  }

  _setSignature(FormFieldState<int> state) async {
    if (_image != null) {
      //await saveUint8ListFile(_image!, getSignatureFilename());
      String n = getSignatureFilename();
      await FileSaver.set(FileSaver(name: n, file: _image!, path: "", questionId: widget.question!.id!, answerHolderId: widget.answerHolder!.id!));

      print("signature filename $n ...........");
      FileSaver? f = await FileSaver.getLastItem();
      if (f != null) {
        log("signature question add to key ${f.name}");
        _fileKey = f.key;
        widget.onSelectedValue!(
          Answer.fill(widget.question!.id, widget.question!.fieldSet, n, n, DateTime.now().toString(), transtypeResourceType(widget.question!.resourcetype!), widget.answerHolder?.id, null,
              fileKey: f.key),
        );
        progress = 0;
        imageState = 1;
        state.didChange(imageState);
      }

      setState(() {});
    }
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
