import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/widgets/auth_widgets/auth_button.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _oldPassController = TextEditingController();

  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
          'Password',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Change Password',
              style: loginSignupInfo,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AuthTextField(
              labelText: 'Enter your old password',
              hidePassword: true,
              controller: _oldPassController,
              trailingIcon: null,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AuthTextField(
              labelText: 'Enter your new password',
              hidePassword: true,
              controller: _newPassController,
              trailingIcon: null,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(bottom: 20),
                  child: AuthButton(
                    'Change',
                    () async {
                      if (_oldPassController.text.trim().length >= 6 &&
                          _newPassController.text.trim().length >= 6) {
                        changePassword(_newPassController.text.trim());
                      } else {
                        Get.defaultDialog();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changePassword(String password) async {
    await _auth.currentUser.updatePassword(password).then((_) {
      print('Password changed');
      Get.defaultDialog(title: 'Password Changed', middleText: 'OK');
      _oldPassController.clear();
      _newPassController.clear();
    }).catchError((e) {
      print('Error ${e.toString()}');
    });
  }
}
