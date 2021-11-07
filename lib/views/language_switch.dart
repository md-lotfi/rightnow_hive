import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

const LANGUAGE_FR = "fr";
const LANGUAGE_AR = "ar";
const LANGUAGE_AR_CODE = "DZ";

class LanguageSwitchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Radio<String>(
                value: LANGUAGE_FR,
                groupValue: context.locale.languageCode,
                onChanged: (v) {
                  context.setLocale(Locale(v!));
                },
              ),
              Text("Français"),
            ],
          ),
          Row(
            children: [
              Radio<String>(
                value: LANGUAGE_AR,
                groupValue: context.locale.languageCode,
                onChanged: (v) {
                  context.setLocale(Locale(v!, LANGUAGE_AR_CODE));
                },
              ),
              Text("عربي"),
            ],
          ),
        ],
      ),
    );
  }
}
