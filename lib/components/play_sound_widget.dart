import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PlaySoundWidget extends StatefulWidget {
  final String fileUrl;
  const PlaySoundWidget({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  @override
  _PlaySoundWidgetState createState() => _PlaySoundWidgetState();
}

class _PlaySoundWidgetState extends State<PlaySoundWidget> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;

  @override
  void initState() {
    _mPlayer?.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    stopPlayer();
    // Be careful : you must `close` the audio session when you have finished with it.
    _mPlayer?.closePlayer();
    _mPlayer = null;

    super.dispose();
  }

  Future<void> stopPlayer() async {
    if (_mPlayer != null) {
      await _mPlayer!.stopPlayer();
    }
  }

  void play() async {
    await _mPlayer?.startPlayer(
        fromURI: widget.fileUrl,
        codec: Codec.mp3,
        whenFinished: () {
          //setState(() {});
        });
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    play();
    return Container();
  }
}
