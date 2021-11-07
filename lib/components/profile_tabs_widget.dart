import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:rightnow/constants/constants.dart';

class ProfileTabsWidget extends StatefulWidget {
  final Widget Function(int display) onTabChange;
  const ProfileTabsWidget({
    Key? key,
    required this.onTabChange,
  }) : super(key: key);

  @override
  _ProfileTabsWidgetState createState() => _ProfileTabsWidgetState();
}

class _ProfileTabsWidgetState extends State<ProfileTabsWidget> {
  int _display = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _display = 0;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  color: _display == 0 ? COLOR_PRIMARY : Colors.grey,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    "Info Personnelles".tr(),
                    style: TextStyle(color: _display == 0 ? Colors.white : COLOR_PRIMARY),
                  ),
                ),
              ),
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _display = 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                color: _display == 1 ? COLOR_PRIMARY : Colors.grey,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text("Etat de santé".tr(), style: TextStyle(color: _display == 1 ? Colors.white : COLOR_PRIMARY)),
              ),
            )),
            //TextButton(onPressed: () {}, child: Text("Info Personnelles".tr())),
            //TextButton(onPressed: () {}, child: Text("Etat de santé".tr())),
          ],
        ),
        //_bodyProfile(snapshot.data!),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 25, bottom: 25),
            child: widget.onTabChange(_display),
            //child: showWidget(_bodyProfile(snapshot.data!), _bodyHealth(LocalUser.fromJson({})), _display == 0),
          ),
        ),
      ],
    );
  }
}
