import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
//import 'package:microphone/microphone.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';

import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/file_saver.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/response_set.dart';

class SoundWebView extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;
  final ResponseSet? responseSet;
  const SoundWebView({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _SoundWebViewState createState() => _SoundWebViewState();
}

class _SoundWebViewState extends State<SoundWebView> with AutomaticKeepAliveClientMixin {
  Answer? _answer;

  double progress = 0;
  FlutterSoundPlayer? _myPlayer = FlutterSoundPlayer();
  //MicrophoneRecorder? _microphoneRecorder = MicrophoneRecorder()..init();
  bool _mRecorderIsInited = false;
  bool _mPlayerIsInited = false;
  String? recordPath;
  Uint8List? _recordedBytes;

  bool hasRecord = false;

  bool _isRecording = false;

  double btnWidth = 20;
  double btnHeight = 10;

  @override
  void initState() {
    if (widget.answerHolder != null) {
      if (widget.answerHolder!.answers != null) {
        if (widget.answerHolder!.answers!.length > 0) {
          for (var answer in widget.answerHolder!.answers!) {
            if (answer.qustionId == widget.question!.id) {
              recordPath = answer.answerValue ?? "";
              hasRecord = true;
              _answer = answer;
              break;
            }
          }
        }
      }
    }

    _myPlayer?.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    //_microphoneRecorder?.dispose();
    //_microphoneRecorder = null;
    _myPlayer?.closePlayer();
    _myPlayer = null;
    super.dispose();
  }

  Future<void> _record(FormFieldState<bool>? state) async {
    if (_mRecorderIsInited) {
      //_microphoneRecorder?.start();
      _isRecording = true;
      setState(() {});
    }
  }

  Future<void> _stopRecorder() async {
    if (_isRecording) {
      //await _microphoneRecorder?.stop();
      _isRecording = false;
      //recordPath = _microphoneRecorder?.value.recording?.url;
      //_recordedBytes = await _microphoneRecorder?.toBytes();
      log("saved record url is $recordPath, ${_recordedBytes?.length}");
      if (_recordedBytes != null) {
        await FileSaver.set(FileSaver(name: recordPath!, path: "", file: _recordedBytes!, questionId: widget.question!.id!, answerHolderId: widget.answerHolder!.id!));
        FileSaver? f = await FileSaver.getLastItem();
        if (f != null) {
          _answer = Answer.fill(
              widget.question!.id, widget.question!.fieldSet, recordPath, recordPath, DateTime.now().toString(), transtypeResourceType(widget.question!.resourcetype!), widget.answerHolder?.id, null,
              question: widget.question, fileKey: f.key);
          widget.onSelectedValue!(
            _answer!,
          );
        }
      }
      setState(() {});
    }
  }

  Future<void> _stopPlayer() async {
    if (_myPlayer?.isPlaying ?? false) {
      await _myPlayer?.stopPlayer();
    }
    setState(() {});
  }

  Future<void> _pausePlayer() async {
    if (_myPlayer?.isPlaying ?? false) {
      await _myPlayer?.pausePlayer();
    }
    setState(() {});
  }

  Future<void> _resumePlayer() async {
    if (_myPlayer?.isPaused ?? false) {
      await _myPlayer?.resumePlayer();
    }
    setState(() {});
  }

  Future<void> _playRecorded() async {
    await _myPlayer?.startPlayer(
      fromURI: recordPath,
      codec: Codec.opusWebM,
      //numChannels: 1,
      //sampleRate: 16000, // Used only with codec == Codec.pcm16
      whenFinished: () {
        setState(() {});
      },
    );
    setState(() {});
  }

  /*bool _isRecording() {
    log("is recording started ${_microphoneRecorder?.value.started}");
    return (_microphoneRecorder?.value.started ?? false);
  }*/

  bool _isPlaying() {
    return (_myPlayer?.isPlaying ?? false);
  }

  bool _isPaused() {
    return (_myPlayer?.isPaused ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return load();
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(widget.question, context.locale.languageCode, widget.responseSet),
            if (!widget.viewOnly && _answer == null)
              FormField<bool>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: hasRecord,
                builder: (FormFieldState<bool> state) {
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: _isRecording ? Colors.red : COLOR_PRIMARY,
                          ),
                          icon: _isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
                          label: _isRecording ? Text("Stop recording".tr()) : Text("Enregistrer un audio".tr()),
                          onPressed: () async {
                            if (!_isRecording) {
                              await _record(state);
                              state.didChange(hasRecord);
                            } else
                              _stopRecorder();
                          },
                        ),
                      ),
                      state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(widget.question)) if (!(value == null ? false : value)) return FORM_RECORD_SOUND;
                  return null;
                },
              ),
            if (_answer != null) _playerMode(),
          ],
        ),
      ),
    );
  }

  Widget _playerMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _playButton(),
        _stopButton(),
        _recordButton(),
      ],
    );
  }

  Widget _playButton() {
    return Visibility(
        visible: !_isRecording,
        child: InkWell(
          onTap: () {
            if (!_isPlaying()) if (!_isPaused())
              _playRecorded();
            else
              _resumePlayer();
            else
              _pausePlayer();
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: btnWidth, vertical: btnHeight),
              decoration: BoxDecoration(
                color: COLOR_PRIMARY,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)),
              ),
              child: Row(
                children: [
                  _isPlaying() ? Icon(Icons.pause, color: Colors.white) : Icon(Icons.play_arrow, color: Colors.white),
                  Text(
                    "Play".tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ));
  }

  Widget _stopButton() {
    return InkWell(
      onTap: () {
        if (!_isRecording)
          _stopPlayer();
        else
          _stopRecorder();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: btnWidth, vertical: btnHeight),
          decoration: BoxDecoration(
            color: COLOR_PRIMARY,
            borderRadius: _isRecording ? BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)) : null,

            //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)),
          ),
          child: Row(
            children: [
              Icon(Icons.stop, color: Colors.white),
              Text(
                "Stop".tr(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }

  Widget _recordButton() {
    return InkWell(
      onTap: () {
        if (!_isRecording) _record(null);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: btnWidth, vertical: btnHeight),
          decoration: BoxDecoration(
            color: _isRecording ? Colors.red : Colors.green,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Row(
            children: [
              _isRecording ? Icon(Icons.fiber_manual_record, color: Colors.white) : Icon(Icons.mic, color: Colors.white),
              Text(
                _isRecording ? "Recording ..." : "Record".tr(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
