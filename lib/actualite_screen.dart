import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/actualite_video_screen.dart';
import 'package:rightnow/article_details_screen.dart';
import 'package:rightnow/blocs/actualite_bloc.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/ActualiteEvent.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ActualitePage extends StatelessWidget {
  const ActualitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActualiteBloc>(context).add(ActualiteEvent.getActualite());
    return ScreenViewerWidget(
        page: Scaffold(
      extendBodyBehindAppBar: true,
      //bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX),
      appBar: AppBar(
        title: Text(""),
        foregroundColor: COLOR_PRIMARY,
        backgroundColor: Colors.transparent,
        elevation: 0,
        /*actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
        ],*/
      ),
      body: Container(
          //padding: EdgeInsets.all(15),
          child: RefreshIndicator(
        child: _builder(context),
        onRefresh: () async {
          BlocProvider.of<ActualiteBloc>(context).add(ActualiteEvent.getActualite());
          return await Future.delayed(
            Duration(seconds: 3),
          );
        },
      )),
    ));
  }

  Widget _builder(BuildContext context) {
    return addBlocHandlerSpinner<ActualiteBloc, ResultState<List<Actualite>>>(
      onFinish: (data) {
        if (data != null) {
          if (data.length > 0) {
            return Container(
              child: _data(context, List.from(data)),
            );
          }
        }
        return Center(
          child: Text(
            "Aucune actualité".tr(),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _getLeading(Actualite actualite) {
    return loadImage(actualite.thumbnail, defaultImg: Icon(Icons.article_outlined, size: 40));
    /*if (actualite.thumbnail != null)
    /*return Image.network(
        actualite.thumbnail!,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.article_outlined, size: 40);
        },
      );*/
    else
      return Icon(Icons.article_outlined, size: 40);*/
  }

  _goto(BuildContext context, Actualite ac) async {
    if (ac.resourceType == RESSOURCE_ARTICLE_ACTU) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ArticleDetailsPage(actualite: ac),
        ),
      );
    } else if (ac.resourceType == RESSOURCE_LINK_ACTU) {
      bool c = await canLaunch(ac.link ?? "");
      if (c) launch(ac.link ?? "");
    } else if (ac.resourceType == RESSOURCE_VIDEO_ACTU) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActualiteVideoPage(actualite: ac),
        ),
      );
    }
  }

  Actualite? _getImportantHeader(List<Actualite> data) {
    for (var item in data) {
      if (item.isImportant == true) {
        return item;
      }
    }
    return null;
  }

  Widget _data(BuildContext context, List<Actualite> data) {
    Actualite? act = _getImportantHeader(data);
    if (act != null) data.removeWhere((element) => element.id == act.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (act != null)
          Expanded(
            child: InkWell(
              onTap: () {
                _goto(context, act);
              },
              child: articleHeader(context, act),
            ),
          ),
        if (act != null)
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Actualités liées".tr(),
              style: TextStyle(fontSize: 22),
            ),
          ),
        if (act == null) SizedBox(height: 100),
        Expanded(
          child: RawScrollbar(
            isAlwaysShown: true,
            thumbColor: COLOR_PRIMARY,
            child: ScrollTouchWidget(listChild: _list(data, act)),
          ),
        )
      ],
    );
  }

  Widget _list(List<Actualite> data, Actualite? header) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 0),
      itemCount: data.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemBuilder: (context, index) {
        print("actualities count officiel ${data.length}");
        Actualite ac = data[index];
        //if (ac.stateName != "Activated") return Container();
        //print("is important " + ac.isImportant.toString());
        return InkWell(
          onTap: () async {
            _goto(context, ac);
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _getLeading(ac),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Jiffy(ac.createdAt).format("dd MMMM yyyy"),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        SizedBox(height: 5),
                        Text(
                          ac.getTitle(context.locale.languageCode),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          ac.resourceType == RESSOURCE_ARTICLE_ACTU ? "Article".tr() : (ac.resourceType == RESSOURCE_VIDEO_ACTU ? "Video".tr() : "Lien".tr()),
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
