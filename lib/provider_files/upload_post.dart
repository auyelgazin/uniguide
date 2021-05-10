import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';

class UploadPost with ChangeNotifier {
  File image;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;

    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }
  }

  File uploadPostImage, uploadPostVideo;
  File get getUploadPostImage => uploadPostImage;
  File get getUploadPostVideo => uploadPostVideo;
  String uploadPostImageUrl, uploadVideoUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  String get getUploadVideoUrl => uploadVideoUrl;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.getImage(source: source);
    uploadPostImageVal == null
        ? print('Select image')
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal.path);

    // uploadPostImage != null
    //     ? showPostImage(context)
    //     : print('Image upload error');

    notifyListeners();
  }

}
