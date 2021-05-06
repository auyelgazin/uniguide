import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LandingUtils with ChangeNotifier{

  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context) async {
    final pickedUserAvatar = await picker.getImage(source: ImageSource.gallery);
    pickedUserAvatar == null
        ? print('Select image')
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    // userAvatar != null
    //     ? Provider.of<LandingService>(context, listen: false)
    //         .showUserAvatar(context)
    //     : print('Image upload error');

    notifyListeners();
  }
 
}