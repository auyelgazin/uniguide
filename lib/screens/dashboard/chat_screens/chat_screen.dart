import 'package:flutter/material.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';

TextEditingController _controller = TextEditingController();

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Napoleon Bonoparte'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            color: lightPurple,
          ),
          Container(
            height: 90,
            color: lightPurple,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        height: 36,
                        child: TextField(
                          controller: _controller,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: white,
                            filled: true,
                            hintText: 'Ask something...',
                            hintStyle: commentHint,
                          ),
                        ),
                      ),
                    ),
                    flex: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: ImageIcon(
                        AssetImage('images/addComment.png'),
                        color: darPurple,
                      ),
                      onPressed: () {
                        print('$arrow Sending message[${_controller.text}]');
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
