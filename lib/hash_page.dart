import 'dart:developer';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/classes/local_db_update.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/welcome_screen.dart';

class HashPage extends StatefulWidget {
  const HashPage({Key? key}) : super(key: key);

  @override
  _HashPageState createState() => _HashPageState();
}

class _HashPageState extends State<HashPage> {
  ApiRepository api = ApiRepository();

  _HashPageState();

  @override
  void initState() {
    /*SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await api.getOrganisation();
      await api.fetchFormState();
      await api.getDiseases();
      //await api.getBloodGroup();
      await api.getProvinces();
      String? hash = await api.fetchHashMain();
      if (hash == null) {
        Hashes? dbHash = await getDataBase<HashDao>().fetchHashesByType(HASH_TYPE_CATEGORIES);
        if (dbHash != null)
          _redirectToHome();
        else
          _noInternetAlert();
        return;
      }
      Hashes? dbHash = await getDataBase<HashDao>().fetchHashesByType(HASH_TYPE_CATEGORIES);

      print("data received 1 $hash");
      bool newForms = true;
      if (dbHash != null) {
        print("data received 2 ${dbHash.hash}, $hash");
        if (dbHash.hash != null) {
          if (hash == dbHash.hash) {
            newForms = false;
          }
        }
      }
      startCategoriesPage(newForms, hash);
    });*/
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await LocalDBUpdate(
        context: context,
        loadFinished: () async {
          Profile? p = await getProfile(context); //getDataBase().profileDao.fetchUserProfile();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        noInternet: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ),
          );
        },
        dbEmptyRestart: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomePage(),
            ),
          );
        },
      ).load();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
      page: Scaffold(
        body: Container(
          //color: Colors.red,
          //alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/loading_bg.gif",
                        //"assets/axxa_splash.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        //height: MediaQuery.of(context).size.height - 70,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 160,
                left: 20,
                right: 20,
                child: Text(
                  "Chargement en cours".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
    /*return FittedBox(
      child: Image(
        image: AssetImage("assets/loading_bg.gif"),
        //fit: BoxFit.contain,
      ),
      fit: BoxFit.fill,
    );*/
    //return hashView(context);
  }

  /*void saveAndStatCategoriesPage(Hashes data) {
    bool newForms = true;
    getDataBase<HashDao>().fetchHashesByType(HASH_TYPE_CATEGORIES).then((result) {
      if (result != null) {
        print("data received " + data.hash!);
        if (result.hash != null) {
          print("data hash is " + result.hash!);
          if (data.hash == result.hash) {
            newForms = false;
          }
        }
      }
      startCategoriesPage(newForms, data.hash!);
    });
  }

  Future<void> startCategoriesPage(bool loadNew, String currentHash) async {
    if (loadNew) {
      print("loading new page");
      //BlocProvider.of<HashBloc>(context).add(HashEvent.loadCategories(currentHash));
      List<FormFields>? result = await api.fetchFormFieldsRaw();
      if (result != null) await getDataBase<FormFieldsDao>().setForms(result, new Hashes.fill(currentHash, HASH_TYPE_CATEGORIES));
      List<FormFields> f = await getDataBase<FormFieldsDao>().loadFormsCategoryId(context, null, HOLDER_ANY_COMPLETED);
      if (f.length > 0) {
        await _uploadForms();
        _redirectToHome();
      } else {
        _databaseEmptyAlert();
      }
    } else {
      print("no result new page");
      await _uploadForms();
      _redirectToHome();
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AnswersUploaderPage(
                  redirect: "homepage",
                )),
      );*/
    }
  }

  Future<void> _uploadForms() async {
    log("uploading non complited forms");
    List<FormFields> fields = await getDataBase<FormFieldsDao>().loadFormsCategoryId(context, null, HOLDER_COMPLETED, searchFormTitle: '');
    for (FormFields field in fields) {
      log("uploading non complited forms ${field.name}");
      await checkSend(context, field, () {}, showResult: false);
    }
  }

  _databaseEmptyAlert() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Erreur".tr(),
      desc: "Base de données vide, continuer ?".tr(),
      buttons: [
        DialogButton(
          child: Text(
            "Oui".tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.red,
          onPressed: () {
            _redirectToHome();
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "Non".tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.red,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ),
            );
          },
          width: 120,
        )
      ],
    ).show();
  }

  _noInternetAlert() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Erreur".tr(),
      desc: "Vous devez avoire une connexion a internet pour télécharger les données".tr(),
      buttons: [
        DialogButton(
          child: Text(
            "Ok".tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.red,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ),
            );
          },
          width: 120,
        )
      ],
    ).show();
  }

  _redirectToHome() async {
    Profile? p = await getProfile(context); //getDataBase().profileDao.fetchUserProfile();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }*/
}
