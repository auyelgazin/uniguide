import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/provider_files/upload_post.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/models/topic.dart';
import 'package:uniguide/services/auth_service.dart';

import 'dashboard_helper.dart';

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

  File file;

  Future selectFile(ImageSource source) async {
    final result = await ImagePicker.platform.pickImage(source: source);

    if (result == null) return;
    final path = result.path;

    setState(() {
      file = File(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Write',
          style: titleStyle,
        ),
        actions: [
          IconButton(
            icon: ImageIcon(
              AssetImage('images/attach.png'),
            ),
            color: Color(0xFF232195),
            iconSize: 20,
            onPressed: () async {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext parentContext) {
                    return Container(
                      height: MediaQuery.of(context).size.width / 2 + 40,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              onPressed: () {},
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  selectFile(ImageSource.camera);
                                  // Get.to(
                                  //   () => Scaffold(
                                  //     backgroundColor: white,
                                  //     appBar: AppBar(
                                  //       leading: IconButton(
                                  //         icon: Icon(Icons.arrow_back_ios,
                                  //             color: black),
                                  //         onPressed: () {},
                                  //       ),
                                  //       centerTitle: true,
                                  //       elevation: 0,
                                  //       title: Text(
                                  //         'cameraFile',
                                  //         style: titleStyle,
                                  //       ),
                                  //       backgroundColor: white,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 2,
                                  child: Center(
                                    child: Text('camera'),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  selectFile(ImageSource.gallery);
                                  //   Get.to(
                                  //     () => Scaffold(
                                  //       backgroundColor: white,
                                  //       appBar: AppBar(
                                  //         leading: IconButton(
                                  //           icon: Icon(Icons.arrow_back_ios,
                                  //               color: black),
                                  //           onPressed: () {
                                  //             Navigator.pop(context);
                                  //           },
                                  //         ),
                                  //         centerTitle: true,
                                  //         elevation: 0,
                                  //         title: Text(
                                  //           'galleryFile',
                                  //           style: titleStyle,
                                  //         ),
                                  //         backgroundColor: white,
                                  //       ),
                                  //     ),
                                  //   );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 2,
                                  child: Center(
                                    child: Text('gallery'),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
          ),
          IconButton(
            icon: ImageIcon(
              AssetImage('images/send.png'),
            ),
            color: Color(0xFF232195),
            iconSize: 20,
            onPressed: () async {
              Provider.of<FirebaseOperations>(context, listen: false)
                  .uploadPostData(titleController.text, {
                'title': titleController.text,
                'image':
                    'https://firebasestorage.googleapis.com/v0/b/uniguide-a6633.appspot.com/o/const_image.png?alt=media&token=6e7d4e3e-4efc-41a2-b182-58ec059b2a80',
                'category': chosenTopic,
                'fullname':
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .getInitFullname,
                'avatar':
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .getInitAvatar,
                'email': Provider.of<FirebaseOperations>(context, listen: false)
                    .geiInitEmail,
                'useruid': Provider.of<Authentication>(context, listen: false)
                    .getUserUid,
                'time': Timestamp.now(),
              }).whenComplete(() {
                print('Post uploaded');
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFB7C1F4).withOpacity(0.3)),
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
                  file == null
                      ? Container()
                      : Container(
                        height: 200,
                          child: Image(
                            image: FileImage(file),
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
                          maxLines: 20,
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
