import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/profile_screens/language_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/settings_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/survey_screen.dart';
import 'package:uniguide/widgets/profile_button.dart';

import 'persontal_data_screen.dart';

class ProfileHelper with ChangeNotifier {
  DashboardController dc = Get.put(DashboardController());
  Widget accountInfo(BuildContext context, dynamic snapshot) {
    return Column(
      children: [
        snapshot.data.data()['avatar'] == noAvatarUrl
            ? CircleAvatar(
                radius: 35,
                child: Text(
                  dc.getInitials(snapshot.data.data()['fullname']),
                ),
              )
            : CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(snapshot.data.data()['avatar']),
              ),
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
