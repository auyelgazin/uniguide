import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';

class ProfileHelper with ChangeNotifier {
  DashboardController _dc = Get.put(DashboardController());
  Widget accountInfo(BuildContext context, dynamic snapshot) {
    return Column(
      children: [
        snapshot.data.data()['avatar'] == noAvatarUrl
            ? CircleAvatar(
              backgroundColor: darPurple,
                radius: 35,
                child: Text(
                  _dc.getInitials(snapshot.data.data()['fullname'], ),
                  style: initialsStyle,
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
