import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';

import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/response_set.dart';

class SoundView extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final ResponseSet? responseSet;
  final bool viewOnly;
  const SoundView({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _SoundViewState createState() => _SoundViewState();
}

class _SoundViewState extends State<SoundView> with AutomaticKeepAliveClientMixin {
  Answer? _answer;
  double progress = 0;

  FlutterSoundRecorder? _myRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer? _myPlayer = FlutterSoundPlayer();
  bool _mRecorderIsInited = false;
  bool _mPlayerIsInited = false;
  String? recordPath;

  bool hasRecord = false;

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

    _myPlayer?.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
    if (!widget.viewOnly)
      _myRecorder?.openAudioSession().then((value) {
        setState(() {
          _mRecorderIsInited = true;
        });
      });
    if (widget.viewOnly && widget.responseSet != null) recordPath = widget.responseSet?.url ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    _myRecorder?.closeAudioSession();
    _myRecorder = null;
    _myPlayer?.closeAudioSession();
    _myPlayer = null;
    super.dispose();
  }

  Future<String> _getRecordPath() async {
    if (!kIsWeb) {
      var tempDir = await getTemporaryDirectory();
      return '${tempDir.path}/myFile_${widget.question?.id}_${Jiffy().unix()}.mp4';
    } else {
      return 'myFile_${widget.question?.id}_${Jiffy().unix()}';
    }
  }

  Future<void> _record(FormFieldState<bool>? state) async {
    log("start recording 3 ${widget.viewOnly}");
    if (widget.viewOnly) return;
    log("start recording 4");
    if (_mRecorderIsInited) {
      log("start recording 5");
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.storage,
      ].request();
      print(statuses[Permission.microphone]);
      print(statuses[Permission.storage]);
      //bool hasPermission = await FlutterAudioRecorder.hasPermissions ?? false;
      if (statuses[Permission.microphone] == PermissionStatus.granted) {
        recordPath = await _getRecordPath();
        print("record path $recordPath");
        _myRecorder
            ?.startRecorder(
          codec: Codec.aacMP4,
          toFile: recordPath,
          sampleRate: 16000,
          numChannels: 1,
        )
            .then((value) {
          hasRecord = true;
          if (state != null) state.didChange(hasRecord);
          setState(() {});
        });
      }
    }
  }

  Future<void> _stopRecorder() async {
    if (_myRecorder?.isRecording ?? false) {
      await _myRecorder?.stopRecorder();
      _answer = Answer.fill(
          widget.question!.id, widget.question!.fieldSet, recordPath, recordPath, DateTime.now().toString(), transtypeResourceType(widget.question!.resourcetype!), widget.answerHolder?.id, null,
          question: widget.question);
      widget.onSelectedValue!(
        _answer!,
      );

      /*String path = await _getRecordPath();
      Duration? a = await flutterSoundHelper.duration(path);
      print("sound helper duration is $a");*/

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
      codec: kIsWeb ? Codec.opusWebM : Codec.aacMP4,
      //numChannels: 1,
      //sampleRate: 16000, // Used only with codec == Codec.pcm16
      whenFinished: () {
        setState(() {});
      },
    );
    setState(() {});
  }

  bool _isRecording() {
    return (_myRecorder?.isRecording ?? false);
  }

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
            if (widget.viewOnly && widget.responseSet != null) _playerMode(),
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
                            backgroundColor: _isRecording() ? Colors.red : COLOR_PRIMARY,
                          ),
                          icon: _isRecording() ? Icon(Icons.stop) : Icon(Icons.mic),
                          label: _isRecording() ? Text("Stop recording".tr()) : Text("Enregistrer un audio".tr()),
                          onPressed: () async {
                            log("start recording 1");
                            if (!_isRecording()) {
                              log("start recording 2");
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
        if (!widget.viewOnly && widget.responseSet == null) _recordButton(),
      ],
    );
  }

  Widget _playButton() {
    return Visibility(
        visible: !_isRecording(),
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
        if (!_isRecording())
          _stopPlayer();
        else
          _stopRecorder();
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: btnWidth, vertical: btnHeight),
          decoration: BoxDecoration(
            color: COLOR_PRIMARY,
            borderRadius: _isRecording() ? BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)) : null,

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
        if (!_isRecording()) _record(null);
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: btnWidth, vertical: btnHeight),
          decoration: BoxDecoration(
            color: _isRecording() ? Colors.red : Colors.green,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Row(
            children: [
              _isRecording() ? Icon(Icons.fiber_manual_record, color: Colors.white) : Icon(Icons.mic, color: Colors.white),
              Text(
                _isRecording() ? "Recording ..." : "Record".tr(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
