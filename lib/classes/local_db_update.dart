import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/rest/ApiRepository.dart';

class LocalDBUpdate {
  final BuildContext context;
  final Function() loadFinished;
  final Function() noInternet;
  final Function() dbEmptyRestart;

  LocalDBUpdate({
    required this.context,
    required this.loadFinished,
    required this.noInternet,
    required this.dbEmptyRestart,
  });

  ApiRepository api = ApiRepository();
  bool _internetAvailable = true;

  Future<bool> load() async {
    await api.getOrganisation();
    await api.fetchFormState();
    await api.getDiseases();
    //await api.getBloodGroup();
    await api.getProvinces();
    String? hash = await api.fetchHashMain();
    if (hash == null) {
      Hashes? dbHash = await getDataBase<HashDao>().fetchHashesByType(HASH_TYPE_CATEGORIES);
      if (dbHash != null) {
        _internetAvailable = true;
        loadFinished();
        //_redirectToHome();
      } else {
        _internetAvailable = false;
        _noInternetAlert();
      }
      return false;
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
    await startCategoriesPage(newForms, hash);
    return true;
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
        //_redirectToHome();
        loadFinished();
      } else {
        _databaseEmptyAlert();
      }
    } else {
      print("no result new page");
      await _uploadForms();
      //_redirectToHome();
      loadFinished();
    }
  }

  Future<void> _uploadForms() async {
    log("Checking internet connection");
    if (_internetAvailable) {
      List<FormFields> fields = await getDataBase<FormFieldsDao>().loadFormsCategoryId(context, null, HOLDER_COMPLETED, searchFormTitle: '');
      for (FormFields field in fields) {
        log("uploading non complited forms ${field.name}");
        await checkSend(context, field, () {}, showResult: false, checkInternet: false);
      }
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
            //_redirectToHome();
            loadFinished();
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
            dbEmptyRestart();
            /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ),
            );*/
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
            noInternet();
          },
          width: 120,
        )
      ],
    ).show();
  }
}
