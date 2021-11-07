import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rightnow/change_password_screen.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/language_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
      page: Scaffold(
        bottomNavigationBar: HomeNavBarComp(NavState.NAV_PROFILE_INDEX),
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: Text("Paramètres".tr()),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: [
              Container(
                margin: isFrench(context) ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Changer la langue".tr(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(8),
                      child: LanguageWidget(),
                    ),
                  ],
                ),
              ),
              /*ListTile(
              title: Text("Changer la langue".tr()),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(8),
                child: LanguageWidget(),
              ),
            ),*/
              Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(),
                    ),
                  );
                },
                title: Text(
                  "Changer le mot de passe".tr(),
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                trailing: Icon(Icons.lock_outlined),
              ),
              Divider(),
              ListTile(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  await getDataBase<LocalUserDao>().removeUser();
                  await getDataBase<FormFieldsDao>().setForms([], null);
                  await getDataBase<AnswerHolderDao>().deleteAnswerHolderAll();
                  Phoenix.rebirth(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                title: Text(
                  "Déconnexion".tr(),
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                trailing: Icon(Icons.logout),
              ),
              /*ListTile(
              title: Text(
                "Contact us".tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.mail),
            ),*/
            ],
          ),
        ),
      ),
    );
  }
}
