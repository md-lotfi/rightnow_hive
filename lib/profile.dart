import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/profile_tabs_widget.dart';
import 'package:rightnow/components/upload_dialog.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/health_profile_widget.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/settings_screen.dart';
import 'package:rightnow/user_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _display = 0;

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: COLOR_PRIMARY,
          elevation: 0,
          title: Text(
            "Profile".tr(),
            //style: TextStyle(color: COLOR_PRIMARY),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                icon: Icon(Icons.settings_outlined)),
          ],
        ),
        body: _body(context),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        return true;
      },
    ));
  }

  Widget _body(BuildContext context) {
    return FutureBuilder<Profile?>(
      future: getProfile(context), //getDataBase().localUser.fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return RefreshIndicator(
                child: _bodyMain(snapshot.data!),
                onRefresh: () async {
                  setState(() {});
                  return await Future.delayed(
                    Duration(seconds: 3),
                  );
                },
              );
            }
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _bodyMain(Profile data) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: HEADER_HEIGHT,
            child: Column(
              children: [
                if (kIsWeb)
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        data.picture ?? "", //"assets/axa-logo.png"
                      ),
                      radius: 60,
                    ),
                  ),
                if (!kIsWeb)
                  UploadDialogWidget(
                    key: UniqueKey(),
                    renderer: Center(
                        child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            data.picture ?? "", //"assets/axa-logo.png"
                          ),
                          radius: 60,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: COLOR_PRIMARY,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    onImageSaved: (image) {
                      print("image saved, reloading ....");
                      setState(() {});
                    },
                  ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: data.name?.toUpperCase() ?? "",
                      style: TextStyle(color: COLOR_PRIMARY, fontSize: 20),
                      children: [
                        TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: data.fname ?? "",
                        ),
                      ],
                    ),
                  ),
                  /*Text(
                              snapshot.data?.name ?? "",
                              style: TextStyle(fontSize: 20),
                            ),*/
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 25, bottom: 25),
            child: _bodyProfile(data),
          )
              /*ProfileTabsWidget(
              onTabChange: (display) {
                return showWidget(_bodyProfile(data), _bodyHealth(LocalUser.fromJson({})), display == 0);
              },
            ),**/
              ),
        ],
      ),
    );
  }

  Widget _bodyProfile(Profile user) {
    return UserProfileWidget(profile: user);
  }

  /*Widget _bodyHealth(LocalUser user) {
    return HealthProfileWidget(
      onResult: (health) async {
        ApiRepository api = ApiRepository();
        showLoaderDialog(context);
        bool res = await api.setUserHealth(health);
        Navigator.pop(context);
        if (res) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Erreur!".tr(),
            desc: "Server error".tr(),
            buttons: [
              DialogButton(
                child: Text(
                  "Ok".tr(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      },
    );
  }*/
}
