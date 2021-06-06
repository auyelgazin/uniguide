import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/message.dart';
import 'package:uniguide/screens/dashboard/chat_screens/models/user.dart';
import 'package:uniguide/screens/dashboard/chat_screens/utils.dart';
import 'package:uniguide/screens/dashboard/chat_screens/widgets/message_widget.dart';
import 'package:uniguide/screens/dashboard/chat_screens/widgets/messages_widget.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;

  ChatScreen(this.user);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final dc = Get.put(DashboardController());
  String message = '';
  var arr = [];
  TextEditingController _controller = TextEditingController();

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await Provider.of<FirebaseOperations>(context, listen: false)
        .uploadMessage(widget.user.uid, message, Provider.of<Authentication>(context, listen: false).getUserUid);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: darPurple,
        ),
        elevation: 0,
        backgroundColor: lightPurple.withOpacity(0.3),
        title: Row(
          children: [
            widget.user.avatar == noAvatarUrl
                ? CircleAvatar(
                    backgroundColor: darPurple,
                    child: Text(
                      dc.getInitials(widget.user.fullname),
                      style: initialsStyle,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.avatar),
                  ),
            const SizedBox(width: 10),
            Text(widget.user.fullname, style: ChatAppbarName),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: StreamBuilder<List<Message>>(
                stream: FirebaseFirestore.instance
                    .collection('chats/${Provider.of<FirebaseOperations>(context, listen: false).getChatCombo(Provider.of<Authentication>(context, listen: false).getUserUid, widget.user.uid)}/messages')
                    .orderBy(MessageField.createdAt, descending: true)
                    .snapshots()
                    .transform(Utils.transformer(Message.fromJson)),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text('Something Went Wrong Try later');
                      } else {
                       
                        final messages = snapshot.data;
                       
                        return messages.isEmpty
                            ? Center(child: Text('No messages'))
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];

                                  return MessageWidget(
                                    message: message,
                                    isMe: message.uid ==
                                        Provider.of<Authentication>(context, listen: false).getUserUid,
                                  );
                                },
                              );
                      }
                  }
                },
              ),
            ),
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
                          onChanged: (value) => setState(() {
                            message = value;
                          }),
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
                        print('$arrow Sending message[$message]...');
                        message.trim().isEmpty ? null : sendMessage();
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
