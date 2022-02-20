import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/forgot_password_confirmation_screen.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/themes/unglow_listview.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  Map<String, String> errorMessage = {};

  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: ScrollTouchWidget(
            listChild: ListView(
              shrinkWrap: true,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/axxa_logo_transparent.png",
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Connectez vous".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: COLOR_PRIMARY, fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Saisissez votre email".tr(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Text(errorMessage['message'] ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                SizedBox(height: 15),
                ScrollConfiguration(
                  behavior: UnGLowListview(),
                  child: Column(
                    //shrinkWrap: true,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email".tr(),
                          style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 25),
                        child: TextFormField(
                          controller: _email,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "name@email.com".tr(),
                            suffixIcon: Icon(Icons.mail_outline),
                          ),
                          validator: (value) {
                            if (!(value?.contains("@") ?? false)) return "Veuillez introduire une adresse email correcte".tr();
                            if (value!.isEmpty) {
                              return "Vous devez saisir un email".tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Je me souviens de mon mot de passe".tr(),
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 25),
                        child: TextButton(
                          onPressed: () async {
                            ApiRepository api = ApiRepository();
                            await api.forgotPassword(_email.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordConfirmationPage(),
                              ),
                            );
                          },
                          child: Text("Envoyer".tr()),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
