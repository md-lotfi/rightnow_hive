import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SoundWidget extends StatefulWidget {
  const SoundWidget({Key? key}) : super(key: key);

  @override
  _SoundWidgetState createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  FlutterSoundRecorder? _myRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;

  @override
  void initState() {
    super.initState();
    _myRecorder?.openRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    _myRecorder?.closeRecorder();
    _myRecorder = null;
    super.dispose();
  }

  Future<String> _getRecordPath() async {
    var tempDir = await getTemporaryDirectory();
    return '${tempDir.path}/myFile.pcm';
  }

  Future<void> _record() async {
    if (_mRecorderIsInited) {
      String o = await _getRecordPath();
      await _myRecorder?.startRecorder(
        codec: Codec.pcm16,
        toFile: o,
        sampleRate: 16000,
        numChannels: 1,
      );
    }
  }

  Future<void> _stopRecorder() async {
    if (_myRecorder?.isRecording ?? false) await _myRecorder?.stopRecorder();
  }

  bool _isRecording() {
    return (_myRecorder?.isRecording ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () async {
              if (!_isRecording())
                await _record();
              else {
                _stopRecorder();
              }
            },
            icon: _isRecording() ? Icon(Icons.stop) : Icon(Icons.record_voice_over_outlined),
            label: _isRecording() ? Text("Stop".tr()) : Text("Start".tr()),
          ),
        ],
      ),
    );
  }
}
