import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/profile_screens/language_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/persontal_data_screen.dart';
import 'package:uniguide/screens/dashboard/profile_screens/profile_helper.dart';
import 'package:uniguide/screens/dashboard/profile_screens/settings_screen.dart';
import 'package:uniguide/widgets/profile_button.dart';
import 'package:get/get.dart';
import 'survey_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 0,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Profile',
            style: titleStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 2,
                      offset: Offset(0, 24),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [ 
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Container(
                              //   child: CircleAvatar(
                              //     radius: 35.0,
                              //     child: Text(
                              //       dashboardController.getInitials(
                              //           Provider.of<FirebaseOperations>(context, listen: false).getInitFullname),
                              //     ),
                              //   ),
                              // ),
                              // Obx(
                              //   () => Container(
                              //     // child: CircleAvatar(
                              //     //   child: Text(dashboardController.getInitials(Provider.of<FirebaseOperations>(context, listen: false).getInitFullname)),
                              //     // ),
                              //     child: dashboardController.avatar.value !=
                              //             null
                              //         ? Container(
                              //             child: CircleAvatar(
                              //               radius: 35.0,
                              //               backgroundImage: NetworkImage(
                              //                   dashboardController
                              //                       .avatar.value),
                              //               // child:
                              //               // FittedBox(child: Image.network('https://firebasestorage.googleapis.com/v0/b/uniguide-a6633.appspot.com/o/avatars%2Fimage_picker3446361867049242902.jpg?alt=media&token=90777e73-9f3d-41cc-a30e-3b8d7fb4c181')),
                              //             ),
                              //           )
                              //         : Container(
                              //             child: CircleAvatar(
                              //               radius: 35.0,
                              //               child: Text(
                              //                 dashboardController.getInitials(
                              //                     dashboardController
                              //                         .fullName.value),
                              //               ),
                              //             ),
                              //           ),
                              //   ),
                              // ),
                              // Obx(
                              //   () => Column(
                              //     children: [
                              //       Text(
                              //         dashboardController.fullName.value,
                              //         style: fullNameStyle,
                              //       ),
                              //       SizedBox(
                              //         height: 8,
                              //       ),
                              //       Text(
                              //         dashboardController.email.value,
                              //         style: positionStyle,
                              //       ),
                              //       Text(
                              //         dashboardController.position.value,
                              //         style: positionStyle,
                              //       ),
                              //     ],
                              //   ),
                              // )
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserUid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Container(
                                      child: Provider.of<ProfileHelper>(context,
                                              listen: false)
                                          .accountInfo(context, snapshot),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfileButtonsColumn(),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<Authentication>(context,
                                              listen: false)
                                          .logOutViaEmail();
                                      Get.offNamed('/login');
                                      // uploadFile();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(19),
                                        color: Color(0xFFF2F3F2),
                                      ),
                                      height: 50,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Image.asset(
                                                'images/logout.png',
                                                height: 18,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Log Out',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF232195),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileButtonsColumn extends StatelessWidget {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          child: Divider(),
        ),
        ProfileButton(
          avatarImage: 'images/account.png',
          title: 'Personal Data',
          onTap: () async {
            Get.to(() => PersonalDataScreen());
          },
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          child: Divider(),
        ),
        ProfileButton(
          avatarImage: 'images/settings.png',
          title: 'Settings',
          onTap: () {
            Get.to(() => SettingsScreen());
          },
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          child: Divider(),
        ),
        ProfileButton(
          avatarImage: 'images/lang.png',
          title: 'Language',
          onTap: () {
            Get.to(() => LanguageScreen());
          },
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          child: Divider(),
        ),
        ProfileButton(
          avatarImage: 'images/survey.png',
          title: 'Survey',
          onTap: () {
            Get.to(() => SurveyScreen());
          },
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          child: Divider(),
        ),
      ],
    );
  }
}
