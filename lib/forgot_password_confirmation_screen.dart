import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/themes/unglow_listview.dart';

class ForgotPasswordConfirmationPage extends StatelessWidget {
  const ForgotPasswordConfirmationPage({Key? key}) : super(key: key);

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
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  size: 80,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Email envoyé!".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: COLOR_PRIMARY, fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Consulter votre boite mail et suivez les instructions pour changer votre mot de passe.".tr(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 25),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text("Revenir en arrière".tr()),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );*/
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Vous n'avez pas reçus l'email? ".tr(),
                      children: [
                        TextSpan(text: "Renvoyer".tr(), style: TextStyle(color: Colors.blue)),
                      ],
                    ),
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
