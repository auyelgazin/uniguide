import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/widgets/auth_widgets/auth_textfield.dart';

class PersonalDataScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 59,
                  backgroundImage: AssetImage('images/profile.png'),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      color: Color(0xFF6200EE),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('sd'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text('yourname'),
                AuthTextField(
                  hintLabelText: null,
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
    );
  }
}
