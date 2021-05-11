import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';

import '../../constants/colors.dart';
import '../../constants/colors.dart';

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
        centerTitle: false,
        leadingWidth: 0,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Chat',
            style: titleStyle,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.search,
                    color: black,
                  ),
                ),

                hintText: 'Search',
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
                      return Container(
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: lightPurple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    case ConnectionState.none:
                      return Text('no data presented)');
                    case ConnectionState.done:
                      return Text('we are done');
                    default:
                      return Container(
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: lightPurple.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: new ListView(
                          children: snapshot.data.docs.map(
                            (DocumentSnapshot documentSnapshot) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 45,
                                  child: new Text(
                                    '${documentSnapshot['fullname']} (${documentSnapshot['position']})',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xFF2F2F32),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
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
