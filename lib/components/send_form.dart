import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/models/FormFields.dart';

class SendFormWidget extends StatelessWidget {
  final FormFields formFields;
  final Function onFinished;
  const SendFormWidget({
    Key? key,
    required this.formFields,
    required this.onFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDataBase<AnswerHolderDao>().fetchAnswerHolderOne(formFields.id!, HOLDER_NOT_COMPLETED),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return TextButton(
              onPressed: () async {
                //BlocProvider.of<AnswersPostBloc>(context).add(AnswersEvent.uploadAnswerHolder());
                await checkSend(context, formFields, () {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    //setState(() {});
                    onFinished();
                  });
                });
              },
              child: Text("Envoyer".tr()),
            );
          } else
            return SizedBox();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
