import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:rightnow/components/combobox_widget.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/health_vaccinated_widget.dart';
import 'package:rightnow/components/pills_widget.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/blood_group_dao.dart';
import 'package:rightnow/db/disease_dao.dart';
import 'package:rightnow/models/blood_group.dart';
import 'package:rightnow/models/disease.dart';
import 'package:rightnow/models/profile.dart';

class HealthObject {
  final bool vaccinated;
  final bool smoker;
  final bool pregnant;
  final int dose;
  final int groupSanguin;
  final double weight;
  final double height;
  final double imc;
  final List<int> diseases;

  HealthObject({
    required this.vaccinated,
    required this.smoker,
    required this.pregnant,
    required this.dose,
    required this.groupSanguin,
    required this.weight,
    required this.height,
    required this.imc,
    required this.diseases,
  });
}

class HealthProfileWidget extends StatelessWidget {
  final Function(HealthObject health)? onResult;
  HealthProfileWidget({Key? key, this.onResult}) : super(key: key);

  bool _vaccinated = false;
  bool _smoker = false;
  bool _pregnant = false;

  int? _gender;
  int _dose = 1;
  int? _groupSanguin;

  List<int> _diseases = [];

  ValueNotifier<int> _refreshImc = ValueNotifier<int>(0);

  TextEditingController _weight = TextEditingController();
  TextEditingController _height = TextEditingController();

  TextEditingController _imc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile?>(
      future: getProfile(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("get profile health profile done ${snapshot.data}");
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              Profile p = snapshot.data!;
              _vaccinated = p.vaccination ?? false;
              _dose = (p.vaccinDose == 0 ? 1 : p.vaccinDose) ?? 0;
              _smoker = p.isSmoker ?? false;
              _pregnant = p.isPregnant ?? false;
              _weight.text = (p.weight ?? 70).toString();
              _height.text = (p.height ?? 170).toString();
              _diseases = p.diseasesId ?? [];
              _groupSanguin = p.bloodGroupId;
              _imc.text = (p.imc ?? 0).toString();
              _gender = p.gender ?? 1;
              print("my geneder is ${p.gender} $_vaccinated $_dose, $_diseases");
            }
          }
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 70,
                child: RawScrollbar(
                  trackVisibility: true,
                  thumbColor: COLOR_PRIMARY,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 25, left: 30, right: 30),
                    child: _body(context),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      HealthObject h = HealthObject(
                        vaccinated: _vaccinated,
                        smoker: _smoker,
                        pregnant: _pregnant,
                        dose: _vaccinated ? _dose : 0,
                        groupSanguin: _groupSanguin!,
                        weight: double.tryParse(_weight.text) ?? 0,
                        height: double.tryParse(_height.text) ?? 0,
                        imc: double.tryParse(_imc.text) ?? 0,
                        diseases: _diseases,
                      );
                      onResult!(h);
                    },
                    child: Text("Valider".tr()),
                  ),
                ),
              ),
            ],
          );
          /*if (onResult != null) {
            return 
          } else
            return _body();*/
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: ScrollTouchWidget(
        listChild: ListView(
          children: [
            HealthVaccinatedWidget(
              defaultDose: _dose,
              defaultVaccinated: _vaccinated,
              onVaccinated: (vaccinated) => _vaccinated = vaccinated,
              onDose: (dose) => _dose = dose,
            ),
            SizedBox(
              height: 20,
            ),
            fieldTitle(context, "Maladie chronique".tr()),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 100,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FutureBuilder<List<Disease>>(
                  future: getDataBase<DiseaseDao>().fetchDisease(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Disease> d = [];
                      if (snapshot.data != null && _diseases.length > 0) {
                        for (Disease item in snapshot.data!) {
                          for (int _l in _diseases) {
                            if (_l == item.id) d.add(item);
                          }
                        }
                      }
                      return PillsWidget(
                        defaultDiseases: d,
                        onChange: (diseases) {
                          if (diseases.length > 0) _diseases = diseases.map((e) => e.id ?? -1).toList();
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            fieldTitle(context, "Etes vous un fumeur?".tr()),
            Container(
              child: ComboField<bool>(
                displayValues: ["Oui".tr(), "Non".tr()],
                values: [true, false],
                resultValue: _smoker,
                valueBuilder: (value) {
                  return value ? Text("Oui".tr()) : Text("Non".tr());
                },
                onResult: (bool r) {
                  _smoker = r;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ...showWidgetList([
              fieldTitle(context, "Etes vous enceinte".tr()),
              Container(
                child: ComboField<bool>(
                  displayValues: ["Oui".tr(), "Non".tr()],
                  values: [true, false],
                  resultValue: _pregnant,
                  valueBuilder: (value) {
                    return value ? Text("Oui".tr()) : Text("Non".tr());
                  },
                  onResult: (bool r) {
                    _pregnant = r;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ], [
              Container()
            ], _gender != 1),
            fieldTitle(context, "Group Sanguin".tr()),
            Container(
              child: FutureBuilder<List<BloodGroup>>(
                future: getDataBase<BloodGroupDao>().fetchBloodGroup(),
                builder: (context, snapshot) {
                  if (ConnectionState.done == snapshot.connectionState) {
                    if (snapshot.hasData) {
                      var dv = snapshot.data?.map((e) => e.name ?? "").toList() ?? [];
                      var v = snapshot.data?.map((e) => e.id!).toList() ?? [];
                      if (_groupSanguin == null) _groupSanguin = v[0];
                      //print('group sanguin data are $_groupSanguin, $dv, $v');
                      return ComboField<int>(
                        displayValues: dv,
                        values: v,
                        resultValue: _groupSanguin,
                        valueBuilder: (value) {
                          return Text((snapshot.data!.firstWhere((element) => element.id == value)).name ?? "");
                        },
                        onResult: (int r) {
                          _groupSanguin = r;
                        },
                      );
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            fieldTitle(context, "Poids (Kg)".tr()),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 25),
              child: TextFormField(
                controller: _weight,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "60".tr(),
                  //suffixIcon: Icon(Icons.mail_outline),
                ),
                onChanged: (value) {
                  _imc.text = ((double.tryParse(value) ?? 0) / pow((((double.tryParse(_height.text)) ?? 0) / 100), 2)).toStringAsFixed(2);
                  _refreshImc.value = _refreshImc.value + 1;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            fieldTitle(context, "Taille (Cm)".tr()),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 25),
              child: TextFormField(
                controller: _height,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "175".tr(),

                  //suffixIcon: Icon(Icons.mail_outline),
                ),
                onChanged: (value) {
                  _imc.text = ((double.tryParse(_weight.text) ?? 0) / pow((((double.tryParse(value)) ?? 0) / 100), 2)).toStringAsFixed(2);
                  _refreshImc.value = _refreshImc.value + 1;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            fieldTitle(context, "Votre IMC est de:".tr()),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: TextFormField(
                controller: _imc,
                textAlign: TextAlign.start,
                readOnly: true,
                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "7.5".tr(),
                  //suffixIcon: Icon(Icons.mail_outline),
                ),
              ),
            ),
            ValueListenableBuilder<int>(
                valueListenable: _refreshImc,
                builder: (context, value, child) {
                  return Container(
                    alignment: isFrench(context) ? Alignment.centerLeft : Alignment.centerRight,
                    child: Text(_getIMCText(), style: TextStyle(color: Colors.red)),
                  );
                }),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  String _getIMCText() {
    if (_imc.text.isEmpty) return "";
    double imc = double.tryParse(_imc.text) ?? 0;
    if (imc < 18.5) return "Insuffisance pondérale (maigreur)".tr();
    if (imc >= 18.5 && imc < 25) return "Corpulence normale".tr();
    if (imc >= 25 && imc < 30) return "Surpoids".tr();
    if (imc >= 30 && imc < 35) return "Obésité modérée".tr();
    if (imc >= 35 && imc < 40) return "Obésité sévère".tr();
    if (imc >= 40) return "Obésité morbide ou massive".tr();
    return "";
  }
}
