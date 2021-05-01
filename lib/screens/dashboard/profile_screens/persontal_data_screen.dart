import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'package:uniguide/services/firestore_service.dart';

class PersonalDataScreen extends StatefulWidget {
  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController fullNameController = TextEditingController();

  DashboardController dashboardController = Get.put(DashboardController());

  String editedFullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF232195),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          'Personal Data',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Obx(
                      () => Container(
                        child: null != null
                            ? Container(
                                child: CircleAvatar(
                                  radius: 50.0,
                                  // backgroundImage:
                                  //     FileImage(imageFile),
                                  // child:
                                  // FittedBox(child: Image.network('https://firebasestorage.googleapis.com/v0/b/uniguide-a6633.appspot.com/o/avatars%2Fimage_picker3446361867049242902.jpg?alt=media&token=90777e73-9f3d-41cc-a30e-3b8d7fb4c181')),
                                ),
                              )
                            : Container(
                                child: CircleAvatar(
                                  radius: 50.0,
                                  child: Text(
                                    dashboardController.getInitials(),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          print('yrs');
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFB7C1F4),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ImageIcon(
                            AssetImage('images/camera.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 4),
                        child: Text('Your name'),
                      ),
                      AuthTextField(
                        labelText: null,
                        hintText: dashboardController.fullName.value,
                        hidePassword: false,
                        controller: fullNameController,
                        trailingIcon: null,
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: AuthButton(
              'Save',
              () async {
                editedFullName = fullNameController.text.trim();
                dashboardController.fullName.value = editedFullName;
                await FirestoreService(uid: auth.currentUser.uid)
                    .updateUserData(
                  fullName: editedFullName,
                  email: auth.currentUser.email,
                  position: dashboardController.position.value,
                );

                // Get.offNamed('/dashboard');
                Get.back();
                // updateUserData()
              },
            ),
          ),
        ],
      ),
    );
  }
}
