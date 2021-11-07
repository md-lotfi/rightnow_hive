import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatefulWidget {
  const SignatureWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignatureWidgetState createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    /*SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);*/
    _controller.addListener(() => print('Value changed'));
  }

  /*@override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_controller.isNotEmpty) {
            Uint8List? i = await _controller.toPngBytes();
            if (i != null) {
              Navigator.pop(context, i);
            } else
              Navigator.pop(context);
          } else
            Navigator.pop(context);
        },
        label: Text(
          'Ok'.tr(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: COLOR_PRIMARY,
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      body: Container(
          child: Stack(
        children: [
          Signature(
            controller: _controller,
            height: MediaQuery.of(context).size.height,
            backgroundColor: Colors.white,
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: TextButton.icon(
                onPressed: () {
                  _controller.clear();
                },
                icon: Icon(Icons.cut_outlined),
                label: Text("Effacer")),
            /*Container(
              child: InkWell(
                onTap: () {
                  _controller.clear();
                },
                child: Container(
                  child: Icon(
                    Icons.cut_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: COLOR_PRIMARY,
                  ),
                ),
              ),
            ),*/
          ),
        ],
      )),
    );
  }
}
