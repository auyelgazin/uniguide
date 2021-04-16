import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WriteScreen extends StatelessWidget {
  int time = DateTime.now().millisecondsSinceEpoch;

  TextEditingController titleController = TextEditingController();

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
                        await FirebaseFirestore.instance.collection('blogs').add({
                          'category': 'Category not chosen',
                          'comments': [
                            {
                              'comment': 'bash',
                              'sendTime': '12:45',
                            }
                          ],
                          'likes': 40,
                          'sendTime': FieldValue.serverTimestamp(),
                          'sender': {
                            'fullName': 'Shawn Carter',
                            'image': 'null',
                          },
                          'title': titleController.text.trim(),
                        });
                        Get.defaultDialog(
                          title: 'You sent request',
                          middleText: 'OK'
                        );
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
              Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFFB7C1F4).withOpacity(0.3)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Choose a community',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.arrow_downward_outlined)
                        ],
                      ),
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
              ])
            ],
          ),
        ),
      ),
    );
  }
}
