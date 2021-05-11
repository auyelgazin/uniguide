import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchC = TextEditingController();

  String searchString;

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
              decoration: InputDecoration(
                fillColor: lightPurple.withOpacity(0.3),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                // border:
              ),
              controller: searchC,
              onChanged: (val) {
                setState(() {
                  searchString = val.toLowerCase();
                });
              },
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (searchString == null || searchString.trim() == '')
                    ? FirebaseFirestore.instance.collection('users').snapshots()
                    : FirebaseFirestore.instance
                        .collection('users')
                        .where('searchIndex', arrayContains: searchString)
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('has error');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.none:
                      return Text('no data presented)');
                    case ConnectionState.done:
                      return Text('we are done');
                    default:
                      return new ListView(
                        children: snapshot.data.docs.map(
                          (DocumentSnapshot documentSnapshot) {
                            return new ListTile(
                              title: Text(
                                  '${documentSnapshot['fullname']}, ${documentSnapshot['position']}'),
                            );
                          },
                        ).toList(),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
