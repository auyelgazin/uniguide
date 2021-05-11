import 'package:flutter/material.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';

class ChatScreen extends StatelessWidget {
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Chat',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: searchC,
            ),
          ],
        ),
      ),
      
    );
  }
}