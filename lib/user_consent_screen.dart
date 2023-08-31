import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/cgu_screen.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';

import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/data_privacy_page.dart';
import 'package:rightnow/preventive1.dart';
import 'package:rightnow/screen_viewer.dart';

class UserConsentScreen extends StatefulWidget {
  const UserConsentScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UserConsentScreenState createState() => _UserConsentScreenState();
}

class _UserConsentScreenState extends State<UserConsentScreen> {
  bool _acceptCGU = false;
  bool _acceptPolitique = false;

  bool _anuthorized = false;
  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
      ),
      body: Container(
        margin: MediaQuery.of(context).size.width > 800 ? EdgeInsets.only(left: 0, right: 0, top: 0) : EdgeInsets.only(left: 25, right: 25, top: 30),
        child: _body(context),
      ),
    ));
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 80,
          child: ScrollTouchWidget(
            listChild: ListView(
              children: [
                Text(
                  "Votre consentement est une nécéssité".tr(),
                  style: TextStyle(
                    color: COLOR_PRIMARY,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsMedium",
                    height: 1.1,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                if (_anuthorized)
                  errorMessage(context, "Votre consentement est nécessaire, vous devez accepter les CGU et les politiques de confidentialités pour continuer à utiliser l'application".tr(), () {
                    setState(() {
                      _anuthorized = false;
                    });
                  }),
                SizedBox(
                  height: 12,
                ),
                RichText(
                  text: TextSpan(
                      text: "En cliquant sur continuer vous acceptez notre ".tr(),
                      style: TextStyle(
                        color: Color(0xFF707070),
                        fontFamily: "PoppinsRegular",
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "politique de confidentialité ".tr(),
                          style: TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CguScreen(
                                    goToDataPrivacy: 3,
                                  ),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: "et confirmer les déclarations suivantes.".tr(),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                        value: _acceptCGU,
                        onChanged: (value) {
                          setState(() {
                            _acceptCGU = value ?? false;
                          });
                        }),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                            text: "J'accepte les ".tr(),
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontFamily: "PoppinsRegular",
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "condition générales d'utilisation ".tr(),
                                style: TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CguScreen(
                                          goToDataPrivacy: null,
                                        ),
                                      ),
                                    );
                                  },
                              ),
                              TextSpan(text: "et ".tr()),
                              TextSpan(
                                text: "la politique de confidentialité ".tr(),
                                style: TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CguScreen(
                                          goToDataPrivacy: 5,
                                        ),
                                      ),
                                    );
                                  },
                              ),
                              //TextSpan(text: "de FahS ".tr()),
                            ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          if (_acceptCGU) {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Preventive1(),
                              ),
                            );*/
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataPrivacyPage(),
                              ),
                            );
                          } else {
                            setState(() {
                              _anuthorized = true;
                            });
                          }
                        },
                        child: Text("Continuer".tr())),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
