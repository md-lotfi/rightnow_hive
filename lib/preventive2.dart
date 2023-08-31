/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/blocs/hash_bloc.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/events/HashEvent.dart';
import 'package:rightnow/hash_page.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/views/language_switch.dart';

class Preventive2 extends StatelessWidget {
  const Preventive2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Stack(
      children: [
        Positioned.fill(
          child: FittedBox(
            child: context.locale.languageCode == LANGUAGE_FR
                ? Image.asset(
                    "assets/prevention2.png",
                  )
                : Image.asset(
                    "assets/prevention2AR.png",
                  ),
            fit: BoxFit.fill,
          ),
        ),
        /*Positioned(
          top: 60,
          left: 30,
          child: Icon(
            Icons.close,
            color: COLOR_PRIMARY,
        ),*/
        Positioned(
          bottom: 20,
          right: 30,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              primary: COLOR_PRIMARY,
            ),
            onPressed: () {
              redirectUser(() {
                BlocProvider.of<HashBloc>(context).add(HashEvent.getCategoriesHash());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HashPage(),
                  ),
                );
              }, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              });
            },
            child: Text(
              "Suivant".tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ));
  }
}
*/