import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmNewPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Mot de passe".tr()),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 70,
              child: _form(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    showLoaderDialog(context);
                    ApiRepository api = ApiRepository();
                    var result = await api.changePassword(_oldPassController.text, _newPassController.text, _confirmNewPassController.text);
                    Navigator.pop(context);
                    if (result is bool) {
                      if (result == true)
                        Navigator.pop(context);
                      else
                        setState(() {
                          _errorMessage = "Une erreur s'est produite".tr();
                        });
                    } else if (result is Map) {
                      if (result.containsKey("message"))
                        setState(() {
                          _errorMessage = result['message'];
                        });
                      else
                        setState(() {
                          _errorMessage = "Une erreur s'est produite".tr();
                        });
                    } else {
                      setState(() {
                        _errorMessage = "Une erreur s'est produite".tr();
                      });
                    }
                  }
                },
                child: Text("Confirmer".tr()),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: ScrollTouchWidget(
        listChild: ListView(
          children: [
            if (_errorMessage != null) ...[
              errorMessage(context, _errorMessage ?? "", () {
                setState(() {
                  _errorMessage = null;
                });
              }),
              SizedBox(
                height: 25,
              ),
            ],
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ancien mot de passe".tr(),
                style: TextStyle(fontSize: 18, color: COLOR_PRIMARY, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 25),
              child: TextFormField(
                controller: _oldPassController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                obscureText: _obscureText1,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText1 = !_obscureText1;
                      });
                    },
                    child: Icon(
                      _obscureText1 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mot de passe ne doit pas ètre vide".tr();
                  }
                  return null;
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nouveau mot de passe".tr(),
                style: TextStyle(fontSize: 18, color: COLOR_PRIMARY, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 25),
              child: TextFormField(
                controller: _newPassController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                obscureText: _obscureText2,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText2 = !_obscureText2;
                      });
                    },
                    child: Icon(
                      _obscureText2 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mot de passe ne doit pas ềtre vide".tr();
                  } else if (value.length < 8) {
                    return "Le mot de passe ne respecte pas les normes 8+ caractères".tr();
                  }
                  return null;
                },
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirmer le nouveau mot de passe".tr(),
                style: TextStyle(fontSize: 18, color: COLOR_PRIMARY, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 25),
              child: TextFormField(
                controller: _confirmNewPassController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                obscureText: _obscureText3,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText3 = !_obscureText3;
                      });
                    },
                    child: Icon(
                      _obscureText3 ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mot de passe ne doit pas ềtre vide".tr();
                  } else if (value.length < 8) {
                    return "Le mot de passe ne respecte pas les normes 8+ caractères".tr();
                  } else if (value != _newPassController.text) {
                    return "Les mots de passe ne sont pas identiques".tr();
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
