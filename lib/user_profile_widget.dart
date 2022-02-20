import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/blocs/profile_update_bloc.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/db/ProvinceDao.dart';
import 'package:rightnow/db/ProvincesDao.dart';
import 'package:rightnow/events/UpdateProfileEvent.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/models/province.dart';
import 'package:rightnow/rest/ApiRepository.dart';

class UserProfileWidget extends StatefulWidget {
  final Profile profile;
  UserProfileWidget({Key? key, required this.profile}) : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _fname = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Jiffy _birthdate = Jiffy().subtract(years: 10);

  int _gender = 0;
  Province? _province;

  LocalUser? l;

  @override
  void initState() {
    log("user profile ${widget.profile.province?.toJson()}");
    _name.text = widget.profile.name ?? "";
    _fname.text = widget.profile.fname ?? "";
    //_email.text = widget.profile.email ?? "";
    if (widget.profile.birthDate != null) _birthdate = Jiffy(widget.profile.birthDate, "yyyy-MM-dd");
    if (widget.profile.province != null) _province = widget.profile.province;
    _gender = widget.profile.gender ?? 0;
    super.initState();
  }

  bool isUpdate = false;
  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      isAlwaysShown: true,
      thumbColor: COLOR_PRIMARY,
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: BlocConsumer<ProfileUpdateBloc, int>(
          buildWhen: (previous, current) => isUpdate,
          listener: (context, state) {},
          builder: (context, state) {
            if (state == 0 || state == 2 || state == -1)
              return Form(key: _formKey, child: ScrollTouchWidget(listChild: _list(context)));
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ), //_list(context)
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView(
      children: [
        fieldTitle(context, "Nom".tr()),
        if (!isUpdate) fieldData(_name.text),
        if (isUpdate) fieldDataEdit(_name),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Prénom".tr()),
        if (!isUpdate) fieldData(_fname.text),
        if (isUpdate) fieldDataEdit(_fname),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Date de naissance".tr()),
        if (!isUpdate) fieldData(widget.profile.birthDate),
        if (isUpdate)
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: Jiffy().subtract(years: 80).dateTime,
              maximumDate: Jiffy().add(years: 1).dateTime, //Jiffy().subtract(years: 1).dateTime,
              initialDateTime: _birthdate.dateTime,
              onDateTimeChanged: (DateTime dateTime) {
                print("dateTime: " + Jiffy(dateTime).format("yyyy-MM-dd"));
                //setState(() {
                _birthdate = Jiffy(dateTime);
                //});
              },
            ),
          ),
        //fieldData(widget.profile.birthDate), //Jiffy(profile.birthDate, "yyyy-MM-dd").format("dd/MM/yyyy")),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Genre".tr()),
        if (!isUpdate) fieldData(widget.profile.gender == 1 ? "Male".tr() : "Female".tr()),
        if (isUpdate)
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(style: BorderStyle.solid, width: 0.80, color: Colors.grey.shade300),
            ),
            child: DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
              isExpanded: true,
              items: ["Male".tr(), "Female".tr()]
                  .map((e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              value: _gender == 1 ? "Male".tr() : "Female".tr(),
              onChanged: (value) {
                setState(() {
                  _gender = value == "Male".tr() ? 1 : 0;
                });
              },
            ),
          ),
        SizedBox(
          height: 20,
        ),

        fieldTitle(context, "Wilaya".tr()),
        if (!isUpdate) fieldData(widget.profile.province?.getName(context.locale.languageCode)),
        if (isUpdate)
          FutureBuilder<List<Province>>(
            future: getDataBase<ProvincesDao>().fetchProvinces(),
            builder: (context, s) {
              if (s.connectionState == ConnectionState.done) {
                if (s.data != null) {
                  if (_province != null) {
                    s.data!.forEach((e) {
                      if (e.nameFr == _province!.nameFr) {
                        //log("server provinc list is ${e.toJson()}");
                        _province = e;
                      }
                    });
                  } else
                    _province = s.data![0];
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(style: BorderStyle.solid, width: 0.80, color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<Province>(
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                      isExpanded: true,
                      items: s.data!
                          .map((e) => DropdownMenuItem<Province>(
                                child: Text(e.getName(context.locale.languageCode)),
                                value: e,
                              ))
                          .toList(),
                      value: _province,
                      onChanged: (value) {
                        setState(() {
                          _province = value;
                        });
                      },
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Email".tr()),
        FutureBuilder<LocalUser?>(
          future: getDataBase<LocalUserDao>().fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              log("user in db is ${snapshot.data?.toJson()}");
              if (snapshot.data != null) {
                l = snapshot.data!;
                _email.text = snapshot.data!.email ?? "";
                return fieldDataEdit(_email, readOnly: !isUpdate);
              }
            }
            return fieldData("");
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () async {
            if (!isUpdate)
              setState(() {
                isUpdate = true;
              });
            else {
              if (l != null) {
                BlocProvider.of<ProfileUpdateBloc>(context).add(UpdateProfileEvent.saveProfile({
                  'user': l!.user,
                  'lastname': _name.text,
                  'firstname': _fname.text,
                  'email': _email.text,
                  'gender': _gender == 1 ? 1 : 2,
                  'province': _province?.toJson(),
                  'birth_date': _birthdate.format("yyyy-MM-dd"),
                }));
              }
            }
          },
          child: !isUpdate ? Text("Modifier".tr()) : Text("Enregistrer".tr()),
        ),
      ],
    );
  }
}
