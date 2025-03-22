import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/views/language_switch.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  _LanguageWidgetState createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (context.locale.languageCode == LANGUAGE_FR) {
          await setLocale(context, LANGUAGE_AR);
          //context.setLocale(Locale(LANGUAGE_AR, LANGUAGE_AR_CODE));
          //await setJiffyLocal(LANGUAGE_AR); //Jiffy.setLocale(LANGUAGE_AR);
        } else {
          await setLocale(context, LANGUAGE_FR);
          //await setJiffyLocal(LANGUAGE_FR);
        }
        setState(() {});
      },
      child: showWidget(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "العربية",
              style: TextStyle(fontSize: 18),
            ),
            Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Français",
              style: TextStyle(fontSize: 18),
            ),
            Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
        context.locale.languageCode == LANGUAGE_FR,
      ),
    );
  }
}
