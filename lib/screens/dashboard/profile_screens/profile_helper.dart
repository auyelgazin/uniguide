import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/profile_screens/language_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/settings_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/survey_screen.dart';
import 'package:uniguide/widgets/profile_button.dart';

import 'persontal_data_screen.dart';

class ProfileHelper with ChangeNotifier {
  Widget accountInfo(BuildContext context, dynamic snapshot) {
    return Column(
      children: [
        Text(
          snapshot.data.data()['fullname'],
          style: fullNameStyle,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          snapshot.data.data()['email'],
          style: positionStyle,
        ),
        Text(
          snapshot.data.data()['position'],
          style: positionStyle,
        ),
      ],
    );
  }
}
