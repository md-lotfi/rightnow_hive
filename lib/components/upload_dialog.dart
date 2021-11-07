import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/upload_avatar.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/rest/ApiRepository.dart';

const int FILE_EMPTY = 0;
const int FILE_ADDED = 1;
const int FILE_UPLOADING = 2;
const int FILE_UPLOADED = 3;
const int FILE_CROPPED = 4;

class UploadDialogWidget extends StatelessWidget {
  final Widget renderer;
  final bool? disableTap;
  final Function(File image)? onImageSaved;

  UploadDialogWidget({
    Key? key,
    required this.renderer,
    this.disableTap,
    this.onImageSaved,
  }) : super(key: key);

  double _progress = 0;
  int _imageState = FILE_EMPTY;
  String _errorMessage = "";
  File? _image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (disableTap != null) if (disableTap == true) return;
        Alert(
          context: context,
          title: "Choose image / take picture".tr(),
          style: AlertStyle(
            titleStyle: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15)),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: UploadAvatarWidget(
                            key: UniqueKey(),
                            imageSource: ImageSource.gallery,
                            title: "Upload Avatar".tr(),
                            mainIcon: Icon(Icons.image, color: COLOR_PRIMARY),
                            onFile: (File image) {
                              setState(() {
                                _imageState = FILE_ADDED;
                                _image = image;
                              });
                              _cropFile(setState);
                            },
                          ),
                        ),
                        Expanded(
                          child: UploadAvatarWidget(
                            key: UniqueKey(),
                            imageSource: ImageSource.camera,
                            title: "Take Picture".tr(),
                            mainIcon: Icon(MdiIcons.camera, color: COLOR_PRIMARY),
                            onFile: (File image) {
                              setState(() {
                                _imageState = FILE_ADDED;
                                _image = image;
                              });
                              _cropFile(setState);
                            },
                          ),
                        ),
                        Container(),
                      ],
                    ),
                    showWidget(
                      Column(
                        children: [
                          _image == null
                              ? Container(
                                  child: Text("Select an image to upload".tr()),
                                )
                              : showWidget(_setProgressBar(setState), Image.file(_image!), _imageState == FILE_UPLOADING),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: kIsWeb ? MainAxisAlignment.center : MainAxisAlignment.spaceAround,
                            children: [
                              if (!kIsWeb)
                                IconButton(
                                  onPressed: () {
                                    _cropFile(setState);
                                  },
                                  icon: Icon(
                                    MdiIcons.crop,
                                    size: 35,
                                    color: Colors.black54,
                                  ),
                                ),
                              IconButton(
                                onPressed: () {
                                  _upload(context, setState);
                                },
                                icon: Icon(
                                  MdiIcons.upload,
                                  size: 35,
                                  color: COLOR_PRIMARY,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(),
                      _imageState == FILE_ADDED || _imageState == FILE_UPLOADED || _imageState == FILE_CROPPED || _imageState == FILE_UPLOADING,
                    ),
                  ],
                ),
              );
            },
          ),
          buttons: [
            DialogButton(
                child: Text("Cancel".tr(), style: TextStyle(color: Colors.white)),
                color: COLOR_PRIMARY,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ).show();
      },
      child: renderer,
    );
  }

  _upload(BuildContext context, StateSetter setState) async {
    ApiRepository apiRepository = ApiRepository();
    setState(() {
      _imageState = FILE_UPLOADING;
    });
    Map<String, dynamic> result = await apiRepository.uploadProfilePicture(_image!, (r, t) {
      setState(() {
        _progress = r / t;
      });
    });
    setState(() {
      _imageState = FILE_UPLOADED;
    });
    if (onImageSaved != null && _image != null) {
      onImageSaved!(_image!);
    }
    Navigator.pop(context);
  }

  _cropFile(StateSetter setState) async {
    if (_image != null) {
      if (!kIsWeb) {
        var imageCropped = await ImageCropper.cropImage(
            sourcePath: _image!.path,
            aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
            androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper'.tr(),
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            ));
        setState(() {
          _image = imageCropped;
          _imageState = FILE_CROPPED;
          print("image state is $_imageState");
        });
      } else {
        setState(() {
          _imageState = FILE_CROPPED;
          print("image state is $_imageState");
        });
      }
    }
  }

  Widget _setProgressBar(StateSetter setState) {
    return SizedBox(
      height: 65,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
                strokeWidth: 8,
                value: _progress,
              ),
            ),
          ),
          Center(
              child: Text(
            "${(_progress * 100).round()}%",
          )),
        ],
      ),
    );
  }
}
