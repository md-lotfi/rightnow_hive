import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/barcode_scanner_page.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/response_set.dart';

class ScannerWidget extends StatefulWidget {
  final Question? question;
  final ResponseSet? responseSet;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const ScannerWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _ScannerWidgetState createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget>
    with AutomaticKeepAliveClientMixin {
  String? selectedBarCode;

  @override
  Widget build(BuildContext context) {
    return load();
  }

  @override
  void initState() {
    if (widget.answerHolder != null) {
      if (widget.answerHolder!.answers != null) {
        if (widget.answerHolder!.answers!.length > 0) {
          for (var answer in widget.answerHolder!.answers!) {
            if (answer.qustionId == widget.question!.id) {
              selectedBarCode = answer.answerValue ?? "";
              break;
            }
          }
        }
      }
    }
    super.initState();
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(widget.question, context.locale.languageCode,
                widget.responseSet),
            if (selectedBarCode != null)
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 10),
                alignment: Alignment.center,
                child: Text(selectedBarCode ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )),
              ),
            if (widget.viewOnly && widget.responseSet != null)
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 10),
                alignment: Alignment.center,
                child: Text(widget.responseSet!.value ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )),
              ),
            if (!widget.viewOnly)
              FormField<String>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: selectedBarCode,
                builder: (FormFieldState<String> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          icon: selectedBarCode != null
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(Icons.qr_code),
                          label: Text("Scanner un QR Code".tr()),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BarcodeScannerPage(
                                  onResult: (value) async {
                                    log("qr codde value is $value");
                                    selectedBarCode = value;
                                    widget.onSelectedValue!(
                                      Answer.fill(
                                          widget.question!.id,
                                          widget.question!.fieldSet,
                                          selectedBarCode,
                                          null,
                                          Jiffy.now(),
                                          transtypeResourceType(
                                              widget.question!.resourcetype!),
                                          widget.answerHolder!.id,
                                          null),
                                    );
                                    state.didChange(selectedBarCode);
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                            /*selectedBarCode =
                                await FlutterBarcodeScanner.scanBarcode(
                                    "#ff6666", "Annuler", true, ScanMode.QR);
                            widget.onSelectedValue!(
                              Answer.fill(
                                  widget.question!.id,
                                  widget.question!.fieldSet,
                                  selectedBarCode,
                                  null,
                                  DateTime.now().toString(),
                                  transtypeResourceType(
                                      widget.question!.resourcetype!),
                                  widget.answerHolder!.id,
                                  null),
                            );
                            state.didChange(selectedBarCode);
                            setState(() {});*/
                          },
                        ),
                      ),
                      state.errorText == null
                          ? Text("")
                          : Text(state.errorText ?? "",
                              style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(widget.question)) if (selectedBarCode == null)
                    return FORM_SELECT_QR;
                  return null;
                },
              ),
            Divider(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
