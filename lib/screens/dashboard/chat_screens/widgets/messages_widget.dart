import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/message.dart';

import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String uid;

  const MessagesWidget({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: Provider.of<FirebaseOperations>(context, listen: false)
            .getMessages(uid),
        builder: (context, snapshot) {
          final messages = snapshot.data;

          if (!snapshot.hasData) {
            print('hasno data');
            print(Provider.of<FirebaseOperations>(context, listen: false)
            .getMessages(uid).toString());
            return Center(
              child: Text('No messages'),
            );
          } else if (snapshot.hasData) {
            print('hasno data');
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageWidget(
                  message: message,
                  isMe: message.uid ==
                      Provider.of<Authentication>(context, listen: false)
                          .getUserUid,
                );
              },
              reverse: true,
            );
          } else {
            print('else');
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
}
