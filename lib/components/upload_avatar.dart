import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rightnow/components/common_widgets.dart';

class UploadAvatarWidget extends StatelessWidget {
  final ImageSource imageSource;
  final String title;
  final Icon mainIcon;
  final Function(XFile file)? onFile; //mobile
  //final Function(Image file)? onImage; //web

  const UploadAvatarWidget({
    Key? key,
    required this.imageSource,
    required this.title,
    required this.mainIcon,
    this.onFile,
    //this.onImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 200,
        //width: 200,
        child: addSetting(
          context,
          title: title,
          icon: mainIcon,
          action: () async {
            await getImage();
          },
        ),
      ),
    );
  }

  Future getImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: imageSource, imageQuality: 65);
    if (pickedFile != null) {
      if (onFile != null) onFile!(pickedFile);
      /*if (kIsWeb) {
        log('image loading in web');
        Image _i = Image.network(pickedFile.path);
        //if (onImage != null) onImage!(_i);
      } else {
        File _f = File(pickedFile.path);
        if (onFile != null) onFile!(_f);
      }*/
    }
  }
}
