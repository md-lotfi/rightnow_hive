import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/fieldsets.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class FormsDescription extends StatelessWidget {
  final FormFields form;

  const FormsDescription({Key? key, required this.form}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return setUp(context);
    /*return BlocBuilder<FieldsetsBloc, ResultState>(builder: (context, state) {
      return setUp(context);
    });*/
  }

  Widget setUp(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Description".tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          form.getName(context.locale.languageCode),
                          style: TextStyle(color: COLOR_PRIMARY, fontSize: 22),
                        ),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
                        child: Text(
                          form.getDescription(context.locale.languageCode),
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ],
                  )),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(),
                  flex: 3,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        if (form.fieldSets == null) return;
                        if (form.fieldSets!.length == 0) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FieldsSetPage(
                                    formId: form.id!,
                                  )),
                        );
                      },
                      child: Text("Ouvrir".tr()),
                    ),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: Container(),
                  flex: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
