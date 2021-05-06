import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/models/topic.dart';
import 'package:uniguide/services/auth_service.dart';

class WriteScreen extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  int time = DateTime.now().millisecondsSinceEpoch;

  TextEditingController titleController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  DashboardController dc = Get.put(DashboardController());

  String chosenTopic;
  List<String> topics = Topic.topics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 60),
                    Text('Write', style: titleStyle),
                    TextButton(
                      onPressed: () async {
                        Provider.of<FirebaseOperations>(context, listen: false).uploadPostData(titleController.text, {
                          'title': titleController.text,
                          'category': chosenTopic,
                          'fullname': Provider.of<FirebaseOperations>(context, listen: false).getInitFullname,
                          'email': Provider.of<FirebaseOperations>(context, listen: false).geiInitEmail,
                          'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
                          'time': Timestamp.now(),
                        }).whenComplete(() {
                          print('Post uploaded');
                        });
                        // await AuthService(auth: auth).initUserData();
                        // AuthService(auth: auth).uploadPostData(titleController.text, {
                        //   'title': titleController.text,
                        //   'category': chosenTopic,
                        //   'fullName': dc.fullName.value,
                        //   'avatar': dc.avatar.value,
                        //   'uid': auth.currentUser.uid,
                        //   'time': Timestamp.now(),
                        // }).whenComplete(() {
                        //   print('post uploaded');
                        // });

                        // await FirebaseFirestore.instance
                        //     .collection('blogs')
                        //     .add({
                        //   'category': 'Category not chosen',
                        //   'comments': [
                        //     {
                        //       'comment': 'bash',
                        //       'sendTime': '12:45',
                        //     }
                        //   ],
                        //   'likes': 40,
                        //   'sendTime': FieldValue.serverTimestamp(),
                        //   'sender': {
                        //     'fullName': 'Shawn Carter',
                        //     'image': 'null',
                        //   },
                        //   'title': titleController.text.trim(),
                        // });
                        // Get.defaultDialog(
                        //     title: 'You sent request', middleText: 'OK');
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF232195),
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFB7C1F4).withOpacity(0.3)),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Choose a community',
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       Icon(Icons.arrow_downward_outlined)
                      //     ],
                      //   ),
                      // ),
                      child: DropdownButton(
                        hint: Text('Choose a topic'),
                        value: chosenTopic,
                        onChanged: (newValue) {
                          setState(() {
                            chosenTopic = newValue;
                          });
                        },
                        items: topics.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFFB7C1F4).withOpacity(0.3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: TextField(
                          controller: titleController,
                          maxLines: 25,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write please your problem',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
