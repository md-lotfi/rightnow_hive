import 'package:rightnow/categories.dart';
import 'package:rightnow/components/db_service.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/profile.dart';
import 'package:rightnow/settings_screen.dart';

const int NAV_HOME_INDEX = 0;
const int NAV_FORMS_INDEX = 1;
const int NAV_SEARCH_INDEX = 2;
const int NAV_HISTORY_INDEX = 3;
const int NAV_PROFILE_INDEX = 4;

enum NavState { NAV_HOME_INDEX, NAV_FORMS_INDEX, NAV_HISTORY_INDEX, NAV_PROFILE_INDEX }

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
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HistoryPage(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
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
      ],
    );
  }
}
