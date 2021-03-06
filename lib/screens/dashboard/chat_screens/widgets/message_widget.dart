import 'package:flutter/material.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({Key key, this.message, this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        // if (!isMe)
        //   CircleAvatar(
        //       radius: 16, backgroundImage: NetworkImage(message.avatar)),
        Container(
          padding: EdgeInsets.only(left:10, right:16, top:16, bottom:16),
          margin: EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: 140),
          decoration: BoxDecoration(
            color: isMe ? lightPurple.withOpacity(0.3) : Color(0xFFe5e5ea).withOpacity(0.8),
            borderRadius: isMe
                ? borderRadius.subtract(BorderRadius.only(bottomRight: radius))
                : borderRadius.subtract(BorderRadius.only(bottomLeft: radius)),
          ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.black : Colors.black),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
        ],
      );
}
