import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';

class UserProfileWidget extends StatelessWidget {
  final Profile profile;
  UserProfileWidget({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      isAlwaysShown: true,
      thumbColor: COLOR_PRIMARY,
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: _list(context),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return ListView(
      children: [
        fieldTitle(context, "Nom".tr()),
        fieldData(profile.name),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Prénom".tr()),
        fieldData(profile.fname),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Date de naissance".tr()),
        fieldData(profile.birthDate), //Jiffy(profile.birthDate, "yyyy-MM-dd").format("dd/MM/yyyy")),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Genre".tr()),
        fieldData(profile.gender == 1 ? "Male".tr() : "Female".tr()),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Wilaya".tr()),
        fieldData(profile.province?.getName(context.locale.languageCode)),
        SizedBox(
          height: 20,
        ),
        fieldTitle(context, "Email".tr()),
        FutureBuilder<LocalUser?>(
          future: getDataBase<LocalUserDao>().fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return fieldData(snapshot.data!.email);
              }
            }
            return fieldData("");
          },
        ),
      ],
    );
  }
}
