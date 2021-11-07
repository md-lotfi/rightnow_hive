import 'package:flutter/material.dart';
import 'package:rightnow/login_page.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool startedPlaying = false;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/splash.mp4");
    /*..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(false);
        _controller.setVolume(0.0);
        _controller.play();
        startedPlaying = true;
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });*/
    _controller.addListener(() {
      if (startedPlaying && !_controller.value.isPlaying) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _controller.initialize();
    await _controller.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<bool>(
        future: started(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
