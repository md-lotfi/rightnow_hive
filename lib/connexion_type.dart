import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnexionTypeScreen extends StatefulWidget {
  ConnexionTypeScreen({Key? key}) : super(key: key);

  @override
  _ConnexionTypeScreenState createState() => _ConnexionTypeScreenState();
}

class _ConnexionTypeScreenState extends State<ConnexionTypeScreen> {
  final PageController _controller = PageController(initialPage: 0);

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _index = _controller.page?.toInt() ?? 0;
        print("index is " + (_index + 1).toString());
      });
    });
  }

  Widget _indice(bool active) {
    return Container(
      height: 8,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: active ? COLOR_PRIMARY : Colors.grey.shade300,
      ),
    );
  }

  Widget _content(BuildContext context, Image image, String title, String subTitle, int index) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: image,
      ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: COLOR_PRIMARY, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 16)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 11)),
                ),
              ),
            ],
          ))
    ]);
  }

  List<Widget> _getItem(BuildContext context) {
    return [
      _content(context, Image.asset('assets/file_1.png'), "Une data accessible instantanément".tr(), "Accédez à votre data à tout moment instantanément".tr(), 0),
      _content(context, Image.asset('assets/file_2.png'), "Crées des formulaires sans limite".tr(), "Des formulaires illimités paramétrables selon votre besoin".tr(), 1),
      _content(context, Image.asset('assets/file_3.png'), "Une data sécurisée".tr(), "Toutes vos données sont sécurisées".tr(), 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: ListView(
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: AdaptiveTextSize().getadaptiveTextSize(context, 360), //420
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _getItem(context).length,
                  itemBuilder: (context, index) {
                    return _getItem(context)[index];
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _indice(_index == 0),
                  SizedBox(
                    width: 5,
                  ),
                  _indice(_index == 1),
                  SizedBox(
                    width: 5,
                  ),
                  _indice(_index == 2),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: kIsWeb ? null : EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(top: 25),
                child: TextButton(
                  onPressed: () {
                    launch("https://app.rightnow-by-brenco.com/");
                  },
                  child: Text("Connexion Admin".tr()),
                ),
              ),
              Container(
                width: double.infinity,
                margin: kIsWeb ? null : EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(top: 25),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text("S'identifier".tr()),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
