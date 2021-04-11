import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Profile',
              style: titleStyle
            ),
          )
        ],
      ),
    );
  }
}