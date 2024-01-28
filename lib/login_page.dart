//import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:rightnow/blocs/hash_bloc.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/events/HashEvent.dart';
import 'package:rightnow/forgot_password_screen.dart';
import 'package:rightnow/hash_page.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/login_error.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/themes/unglow_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  final _organisationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginError? loginError;

  bool _obscureText = true;

  Future<void> _loginUser(LocalUser user) async {
    showLoaderDialog(context, title: "Authentification en cours ...".tr());
    ApiRepository api = ApiRepository();
    dynamic auth = await api.loginUserRaw(user);
    if (auth is String) {
      print("storing api key in shared preferences " + auth);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(AUTH_KEY, auth);
      //await getDataBase<LocalUserDao>().setLocalUser(user);
      int userId = await api.currentUserRaw();
      log("user id is $userId");
      if (userId != -1) {
        print("registring user firbase topic user-$userId");
        String? token = await FirebaseMessaging.instance.getToken();

        print("firebase token is $token");
        if (token != null) {
          ApiRepository api = ApiRepository();
          await api.addFirebaseRegistratioinId(userId, token);
        }
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HashPage()));
        //return LoginError(status: 1, message: 'ok', error: null);
      }
    } else if (auth is LoginError) {
      Navigator.pop(context);
      setState(() {
        loginError = auth;
      });
    } else
      Navigator.pop(context);
  }

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _getLocalUser().then((LocalUser? user) async {
        print("local user is $user");
        if (user != null) {
          print("local user is not null");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? key = prefs.getString(AUTH_KEY);
          if (key != null) {
            print("key is not null");
            BlocProvider.of<HashBloc>(context).add(HashEvent.getCategoriesHash());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HashPage(),
              ),
            );
          } else {
            await _loginUser(user);
          }
        }
      });
    });
    super.initState();
  }

  Future<LocalUser?> _getLocalUser() async {
    return await getDataBase<LocalUserDao>().fetchUser();
  }

  LoginPageState();
  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: COLOR_PRIMARY,
          child: Container(
            margin: kIsWeb ? null : EdgeInsets.all(30),
            child: ScrollTouchWidget(
              listChild: ListView(
                shrinkWrap: true,
                children: [
                  if (!kIsWeb)
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/axxa_logo_transparent.png",
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  if (!kIsWeb) SizedBox(height: 30),
                  if (kIsWeb)
                    if (MediaQuery.of(context).size.width > 800)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/axxa_logo_transparent.png",
                                width: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            "Connectez vous".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: COLOR_PRIMARY,
                              fontSize: MediaQuery.of(context).size.width > 800 ? AdaptiveTextSize().getadaptiveTextSize(context, 25) : AdaptiveTextSize().getadaptiveTextSize(context, 25),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  if (!kIsWeb)
                    Text(
                      "Connectez vous".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: COLOR_PRIMARY,
                        fontSize: MediaQuery.of(context).size.width > 800 ? AdaptiveTextSize().getadaptiveTextSize(context, 25) : AdaptiveTextSize().getadaptiveTextSize(context, 25),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    "Connectez-vous aves les données que vous avez saisies lors de votre inscription".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 14)),
                  ),
                  SizedBox(height: 10),
                  if (loginError != null)
                    errorMessage(context, loginError?.message ?? "Nom d'utilisateur, mot de passe, ou clé organisation incorrect".tr(), () {
                      setState(() {
                        loginError = null;
                      });
                    }),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: ScrollConfiguration(
                      behavior: UnGLowListview(),
                      child: Column(
                        //shrinkWrap: true,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /*Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Organisation key".tr(),
                              style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 25),
                            child: TextFormField(
                              controller: _organisationController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "xxxxxxx",
                                suffixIcon: Icon(Icons.vpn_key_outlined),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vous devez saisir une clé organisation".tr();
                                }
                                return null;
                              },
                            ),
                          ),*/
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Nom d'utilisateur ou e-mail".tr(),
                              style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 25),
                            child: TextFormField(
                              controller: _usernameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.none,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "name@email.com".tr(),
                                suffixIcon: Icon(Icons.mail_outline),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vous devez saisir un email".tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Mot de passe".tr(),
                              style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 25),
                            child: TextFormField(
                              controller: _passController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText ? Icons.visibility_off : Icons.visibility,
                                  ),
                                ),
                                border: OutlineInputBorder(),
                                hintText: "Mot de passe".tr(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Mot de passe ne doit pas ềtre vide".tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPasswordPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Mot de passe oublié ?".tr(),
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 25),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _loginUser(
                                    LocalUser.fill(
                                      username: _usernameController.text.toLowerCase().trim(),
                                      password: _passController.text,
                                      organization: "STA399", //_organisationController.text,
                                    ),
                                  );
                                }
                              },
                              child: Text("S'identifier".tr()),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          /*Container(
                        alignment: Alignment.centerRight,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(text: "Vous n'avez pas de compte ? ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "Enregistrer vous", style: TextStyle(color: Colors.blue)),
                        ])),
                      ),*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
