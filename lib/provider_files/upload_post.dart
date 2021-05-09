import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/dashboard_screen.dart';

class UploadPost with ChangeNotifier {
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

  selectPostType(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.width / 2 + 40,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {},
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        pickUploadPostImage(context, ImageSource.camera)
                            .whenComplete(() {
                          Get.to(
                            () => Scaffold(
                              backgroundColor: white,
                              appBar: AppBar(
                                leading: IconButton(
                                  icon:
                                      Icon(Icons.arrow_back_ios, color: black),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                centerTitle: true,
                                elevation: 0,
                                title: Text(
                                  'choosenFile',
                                  style: titleStyle,
                                ),
                                backgroundColor: white,
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: Text('camera'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                         pickUploadPostImage(context, ImageSource.gallery)
                            .whenComplete(() {
                          Get.to(
                            () => Scaffold(
                              backgroundColor: white,
                              appBar: AppBar(
                                leading: IconButton(
                                  icon:
                                      Icon(Icons.arrow_back_ios, color: black),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                centerTitle: true,
                                elevation: 0,
                                title: Text(
                                  'choosenFile',
                                  style: titleStyle,
                                ),
                                backgroundColor: white,
                              ),
                            ),
                          );
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: Text('gallery'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  showPostImage() {}
}
