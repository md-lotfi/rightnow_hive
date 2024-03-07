import 'package:flutter/material.dart';

class QuestionsValidateDialog extends StatefulWidget {
  final String title, descriptions, textPositive, textNegative;
  final Function(int) onButtonClicked;

  const QuestionsValidateDialog({Key? key, required this.title, required this.descriptions, required this.onButtonClicked, required this.textPositive, required this.textNegative}) : super(key: key);
  @override
  _QuestionsValidateDialogState createState() => _QuestionsValidateDialogState();
}

class _QuestionsValidateDialogState extends State<QuestionsValidateDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),*/
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          widget.onButtonClicked(1);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.textPositive,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          widget.onButtonClicked(-1);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          widget.textNegative,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
