import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/about_screen.dart';
import 'package:rightnow/actualite_screen.dart';
import 'package:rightnow/categories.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/fcm_counter_widget.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/super_category_dao.dart';
import 'package:rightnow/lien_utiles.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/models/super_category.dart';
import 'package:rightnow/notification_history.dart';
import 'package:rightnow/profile.dart';
import 'package:rightnow/screen_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    /*FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // Getting the token makes everything work as expected
    _firebaseMessaging.getToken().then((String? token) {
      print("token is $token");
      assert(token != null);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      setState(() {});
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        /*await getDataBase<FCMNotificationsDao>().insertFCMNotification(FCMNotification(
          id: DateTime.now().millisecondsSinceEpoch,
          title: message.notification?.title ?? "",
          message: message.notification?.body ?? "",
          viewed: 0,
        ));*/

      }
    });*/

    /*FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("main screen handling message: $event");
      
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      print("main screen handling message: $message");
      setState(() {
        _fcmCounter++;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: WillPopScope(
      child: Scaffold(
        //backgroundColor: Colors.grey.shade50,
        bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX),
        body: _body(context),
      ),
      onWillPop: () async {
        return false;
      },
    ));
  }

  Widget _body(BuildContext context) {
    return Column(children: [
      HeaderBarWidget(
        height: 120,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: isFrench(context) ? null : 0,
                  left: isFrench(context) ? 0 : null,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/axa-logo.png",
                        fit: BoxFit.contain,
                        width: 70,
                      ),
                      FutureBuilder<Profile?>(
                        future: getProfile(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                return Container(
                                  margin: isFrench(context) ? EdgeInsets.only(left: 15) : EdgeInsets.only(right: 15),
                                  alignment: Alignment.center,
                                  //color: Colors.yellow,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Bonjour".tr(),
                                        style: TextStyle(
                                          color: COLOR_PRIMARY,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 16),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data?.fname ?? "",
                                        style: TextStyle(
                                          color: COLOR_PRIMARY,
                                          fontWeight: FontWeight.normal,
                                          fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: isFrench(context) ? 0 : null,
                  left: isFrench(context) ? null : 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationHistoryPage(),
                        ),
                      );
                    },
                    child: FCMCounterWidget(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: RawScrollbar(
            thumbColor: COLOR_PRIMARY,
            child: ListView(
              children: [
                FutureBuilder<List<SuperCategory>>(
                  future: getDataBase<SuperCategoryDao>().fetchSuperCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print("sueprcatgegory count ${snapshot.data?.length}");
                      List<Widget> w = [];
                      for (SuperCategory item in snapshot.data ?? []) {
                        w.add(_topButton(item.title(context.locale.languageCode), item.icon, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesPage(
                                superCategory: item,
                              ),
                            ),
                          );
                        }));
                        w.add(SizedBox(height: 15));
                      }
                      return Column(
                        children: w,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ActualitePage(),
                            ),
                          );
                        },
                        child: _button(context, "Actualités".tr(), EdgeInsets.only(right: 0), Icon(Icons.article_outlined, color: COLOR_PRIMARY, size: 30)),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        child: _button(context, "Profil".tr(), EdgeInsets.only(left: 0), Icon(Icons.person_outline, color: COLOR_PRIMARY, size: 30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LienUtiles(),
                            ),
                          );
                        },
                        child: _button(context, "Liens utiles".tr(), EdgeInsets.only(right: 0), Icon(Icons.link_outlined, color: COLOR_PRIMARY, size: 30)),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ),
                          );
                        },
                        child: _button(context, "A propos".tr(), EdgeInsets.only(left: 0), Icon(Icons.info_outline, color: COLOR_PRIMARY, size: 30)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _topButton(String title, String? iconUrl, Function() onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.only(right: 20, left: 20),
        decoration: BoxDecoration(
          color: COLOR_PRIMARY,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*Icon(
              Icons.check_circle_outlined,
              size: 30,
              color: Colors.white,
            ),*/
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            if (iconUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: loadImage(
                  iconUrl,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _button(BuildContext context, String text, EdgeInsets margin, Icon icon) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      //margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 0.9,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: icon,
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: COLOR_PRIMARY, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15)),
            ),
          ),
        ],
      ),
    );
  }
}
