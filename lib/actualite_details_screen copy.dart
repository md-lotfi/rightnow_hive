/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/actualite_video_screen.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const RESSOURCE_VIDEO_ACTU = "VideoActu";
const RESSOURCE_ARTICLE_ACTU = "ArticleActu";
const RESSOURCE_LINK_ACTU = "LinkActu";

class ActualiteDetailsPage extends StatelessWidget {
  final Actualite actualite;
  const ActualiteDetailsPage({
    Key? key,
    required this.actualite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      appBar: AppBar(
        title: Text("Rightnow"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              actualite.title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(Jiffy(actualite.createdAt).format("dd/MM/yyyy"),
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15,
                )),
            SizedBox(
              height: 25,
            ),
            ..._getActualiteType(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _getActualiteType(BuildContext context) {
    switch (actualite.resourceType) {
      case RESSOURCE_ARTICLE_ACTU:
        return _getArticle();
      case RESSOURCE_VIDEO_ACTU:
        return _getVideo(context);
      case RESSOURCE_LINK_ACTU:
        return _getLink();
      default:
        return [Container()];
    }
  }

  List<Widget> _getArticle() {
    return [
      InkWell(
        child: Image.network(actualite.image ?? ""),
      ),
      SizedBox(
        height: 25,
      ),
      Text(
        actualite.content ?? "",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    ];
  }

  List<Widget> _getVideo(BuildContext context) {
    String id = YoutubePlayer.convertUrlToId(actualite.link ?? "") ?? "";
    return [
      SizedBox(
        height: 25,
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActualiteVideoPage(actualite: actualite),
            ),
          );
        },
        child: Image.network("https://img.youtube.com/vi/$id/0.jpg"),
      ),
      SizedBox(
        height: 25,
      ),
      Text(
        actualite.description ?? "",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    ];
  }

  List<Widget> _getLink() {
    return [
      SizedBox(
        height: 25,
      ),
      SimpleUrlPreview(
        bgColor: Colors.white,
        url: actualite.link ?? "",
      ),
      SizedBox(
        height: 25,
      ),
      Text(
        actualite.description ?? "",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    ];
  }

  /*Widget _data(List<Actualite> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
            if (data[index].type == 1 || (data[index].type == 3)) {
              String _url = data[index].link ?? "";
              //await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
            }
          },
          title: Text(data[index].title ?? ""),
          subtitle: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "Ajouté le ".tr(),
                  children: [
                    TextSpan(text: Jiffy(data[index].createdAt).format("dd/MM/yyyy")),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }*/
}
*/