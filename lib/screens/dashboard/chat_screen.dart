import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Chat', style: titleStyle),
                ),
                
              ],
            ),
          )
        ],
      ),
      
    );
  }
}