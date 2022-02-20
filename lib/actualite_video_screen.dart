import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class ActualiteVideoPage extends StatefulWidget {
  final Actualite actualite;
  const ActualiteVideoPage({
    Key? key,
    required this.actualite,
  }) : super(key: key);

  @override
  _ActualiteVideoPageState createState() => _ActualiteVideoPageState();
}

class _ActualiteVideoPageState extends State<ActualiteVideoPage> {
  late YoutubePlayerController _controller;
  /* = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(widget.actualite.link ?? "") ?? "",
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );*/

  @override
  void initState() {
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);*/ //360
    //print("playing video from youtube ${widget.actualite.link}");
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.actualite.link ?? "") ?? "",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }

  void listener() {
    //print("youtube state changed");
    /*if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
            /*appBar: AppBar(
          title: Text(""),
        ),
        bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX, getDataBase()),*/
            body: Container(
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: COLOR_PRIMARY,
          bottomActions: [
            CurrentPosition(),
            FullScreenButton(),
            ProgressBar(isExpanded: true),
          ],
          progressColors: ProgressBarColors(
            playedColor: COLOR_PRIMARY,
            handleColor: Colors.red,
          ),
          onReady: () {
            _controller.addListener(listener);
          },
        ),
        builder: (context, player) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 60,
                child: ScrollTouchWidget(
                  listChild: ListView(
                    children: [
                      AppBar(
                        title: Text("Actualité".tr()),
                      ),
                      player,
                      articlaHeaderColumn(context, widget.actualite),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Html(
                          data: widget.actualite.getDescription(context.locale.languageCode),
                          style: {
                            "p": Style(
                              //color: Colors.black,
                              //fontSize: FontSize(15),
                              fontFamily: "PoppinsMedium",
                              textAlign: TextAlign.justify,
                            ),
                          },
                          onLinkTap: (url, _, __, ___) async {
                            print("Opening $url...");
                            bool b = await canLaunch(url ?? "");
                            if (b) launch(url ?? "");
                          },
                        ),
                        /*Text(
                        widget.actualite.getDescription(context.locale.languageCode),
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 13)),
                      ),*/
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: HomeNavBarComp(NavState.NAV_HOME_INDEX),
              ),
            ],
          );
        },
      ),
    )));
  }
}
