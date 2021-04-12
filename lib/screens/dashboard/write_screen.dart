import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';

class WriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: Text(
              'Write',
              style: titleStyle
            ),
          )
        ],
      ),
    );
  }
}