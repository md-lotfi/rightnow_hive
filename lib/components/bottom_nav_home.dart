import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/profile.dart';
import 'package:rightnow/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';

const int NAV_HOME = 0;
const int NAV_HISTORY = 1;
const int NAV_PROFILE = 2;
const int NAV_SETTINGS = 3;
const int NAV_CHAT = 4;

enum NavState { NAV_HOME, NAV_HISTORY, NAV_PROFILE, NAV_SETTINGS } //, NAV_CHAT

class HomeNavBarComp extends StatelessWidget {
  final NavState currentIndex;

  HomeNavBarComp(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: COLOR_PRIMARY,
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.grey.shade400,
      currentIndex: currentIndex.index,
      onTap: (int index) {
        switch (index) {
          case NAV_HOME:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
            break;
          case NAV_HISTORY:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryPage(),
              ),
            );
            break;
          case NAV_PROFILE:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
            break;
          case NAV_SETTINGS:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
            break;
          case NAV_CHAT:
            launch("https://tawk.to/startupdzsupport",
                forceWebView: true,
                enableJavaScript: true,
                enableDomStorage: true);
            break;
        }
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Accueil".tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "Historique".tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: "Profil".tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Configuration".tr(),
        ),
        /*BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: "Chat".tr(),
        ),*/
      ],
    );
  }
}
