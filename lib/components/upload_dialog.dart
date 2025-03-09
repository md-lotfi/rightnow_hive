import 'dart:developer';
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

// ignore: must_be_immutable
class UploadDialogWidget extends StatefulWidget {
  final Widget renderer;
  final bool? disableTap;
  final Function(XFile image)? onImageSaved;

  UploadDialogWidget({
    Key? key,
    required this.renderer,
    this.disableTap,
    this.onImageSaved,
  }) : super(key: key);

  @override
  State<UploadDialogWidget> createState() => _UploadDialogWidgetState();
}

class _UploadDialogWidgetState extends State<UploadDialogWidget> {
  double _progress = 0;

  int _imageState = FILE_EMPTY;

  XFile? _image;

  Widget _getImage(XFile f) {
    if (kIsWeb) {
      return Image.network(f.path);
    } else {
      return Image.file(File(f.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.disableTap != null) if (widget.disableTap == true) return;
        Alert(
          context: context,
          title: "Choose image / take picture".tr(),
          style: AlertStyle(
            titleStyle: TextStyle(
                fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15)),
          ),
          content: Container(
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
                        onFile: (XFile image) {
                          setState(() {
                            _imageState = FILE_ADDED;
                            _image = image;
                          });
                          _cropFile();
                        },
                      ),
                    ),
                    Expanded(
                      child: UploadAvatarWidget(
                        key: UniqueKey(),
                        imageSource: ImageSource.camera,
                        title: "Take Picture".tr(),
                        mainIcon: Icon(MdiIcons.camera, color: COLOR_PRIMARY),
                        onFile: (XFile image) {
                          setState(() {
                            _imageState = FILE_ADDED;
                            _image = image;
                          });
                          _cropFile();
                        },
                      ),
                    ),
                  ],
                ),
                showWidget(
                  Column(
                    children: [
                      _image == null
                          ? Container(
                              child: Text("Select an image to upload".tr()),
                            )
                          : showWidget(
                              _setProgressBar(setState),
                              _getImage(_image!),
                              _imageState == FILE_UPLOADING),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: kIsWeb
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceAround,
                        children: [
                          if (!kIsWeb)
                            IconButton(
                              onPressed: () {
                                _cropFile();
                              },
                              icon: Icon(
                                MdiIcons.crop,
                                size: 35,
                                color: Colors.black54,
                              ),
                            ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              MdiIcons.close,
                              size: 35,
                              color: COLOR_PRIMARY,
                            ),
                          ),
                          /*IconButton(
                            onPressed: () {
                              _upload(context);
                            },
                            icon: Icon(
                              MdiIcons.upload,
                              size: 35,
                              color: COLOR_PRIMARY,
                            ),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                  Container(),
                  _imageState == FILE_ADDED ||
                      _imageState == FILE_UPLOADED ||
                      _imageState == FILE_CROPPED ||
                      _imageState == FILE_UPLOADING,
                ),
              ],
            ),
          ),
          buttons: [
            DialogButton(
                child: Text("Enregistrer".tr(),
                    style: TextStyle(color: Colors.white)),
                color: COLOR_PRIMARY,
                onPressed: () {
                  _upload(context);
                }),
          ],
        ).show();
      },
      child: widget.renderer,
    );
  }

  _upload(BuildContext context) async {
    if (_image == null) return;
    ApiRepository apiRepository = ApiRepository();
    setState(() {
      _imageState = FILE_UPLOADING;
    });
    //Map<String, dynamic> result =
    await apiRepository.uploadProfilePicture(_image!, (r, t) {
      setState(() {
        _progress = r / t;
      });
    });
    setState(() {
      _imageState = FILE_UPLOADED;
    });
    if (widget.onImageSaved != null && _image != null) {
      widget.onImageSaved!(_image!);
    }
    Navigator.pop(context);
  }

  _cropFile() async {
    if (_image != null) {
      log('calling cropImage *******************');
      //if (!kIsWeb) {
      var imageCropped =
          await ImageCropper().cropImage(sourcePath: _image!.path, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr(),
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
        WebUiSettings(
          context: context,
          cropBoxResizable: true,
          checkOrientation: true,
          zoomable: true,
        ),
      ]);
      if (imageCropped != null) {
        log('image cropped != null');
        setState(() {
          //_image = File(imageCropped.path);
          _image = XFile(imageCropped.path);
          _imageState = FILE_CROPPED;
          print("image state is $_imageState");
        });
      }
      //} else {
      setState(() {
        _imageState = FILE_CROPPED;
        print("image state is $_imageState");
      });
      //}
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
