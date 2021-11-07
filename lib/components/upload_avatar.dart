import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rightnow/components/common_widgets.dart';

class UploadAvatarWidget extends StatelessWidget {
  final ImageSource imageSource;
  final String title;
  final Icon mainIcon;
  final Function(File file)? onFile; //mobile
  final Function(Image file)? onImage; //web

  const UploadAvatarWidget({
    Key? key,
    required this.imageSource,
    required this.title,
    required this.mainIcon,
    this.onFile,
    this.onImage,
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
    PickedFile? pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      if (kIsWeb) {
        Image _i = Image.network(pickedFile.path);
        if (onImage != null) onImage!(_i);
      } else {
        File _f = File(pickedFile.path);
        if (onFile != null) onFile!(_f);
      }
    }
  }
}
