import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/themes/unglow_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  final _organisationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: ListView(
            shrinkWrap: true,
            /*mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,*/
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
                "Enregistrez vous".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: COLOR_PRIMARY, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Connecter-vous aves les données que vous avezz saisies lors de votre inscription",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: ScrollConfiguration(
                  behavior: UnGLowListview(),
                  child: Column(
                    //shrinkWrap: true,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nom Complet".tr(),
                          style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 25),
                        child: TextFormField(
                          controller: _usernameController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "eg: paul mike".tr(),
                            suffixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Vous devez saisir nom complet".tr();
                            }
                            return null;
                          },
                        ),
                      ),
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
                          controller: _usernameController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
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
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "6+ caractère, 1 lettre majuscule".tr(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mot de passe ne doit pas etre vide".tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirmez votre mot de passe".tr(),
                          style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 25),
                        child: TextFormField(
                          controller: _passController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Confirmez mot de passe".tr(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Passwords doesn't match".tr();
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 25),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginHadlerPage(
                                    appDatabase: appDatabase,
                                    localUser: LocalUser.fill(
                                      username: _usernameController.text,
                                      password: _passController.text,
                                      organization: _organisationController.text,
                                    ),
                                  ),
                                ),
                              );*/
                            }
                          },
                          child: Text("Créer un compte".tr()),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(text: "Vous avez compte ? ", style: TextStyle(color: Colors.grey)),
                          TextSpan(text: "S'identifier", style: TextStyle(color: Colors.blue)),
                        ])),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
