import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:get/get.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/models/topic.dart';

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
  String imageUrl;

  final snackBar = SnackBar(content: Text('Post Uploaded!'));

  Future selectFile(ImageSource source) async {
    final result =
        await ImagePicker.platform.pickImage(source: source, imageQuality: 20);

    if (result == null) return;
    final path = result.path;

    setState(() {
      file = File(path);
    });
  }

  Future sendImage() async {
    var storageImage = FirebaseStorage.instance.ref().child(file.path);
    var task = storageImage.putFile(file);
    imageUrl = await (await task).ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Write a Blog',
            style: titleStyle,
          ),
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
                      child: SingleChildScrollView(
                                              child: Column(
                          children: [
                            Container(
                              height: 40,
                              child: IconButton(
                                icon: Icon(Icons.keyboard_arrow_down),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: 40,),
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
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width / 8,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            child: Image(
                                              color: darPurple,
                                              image: AssetImage(
                                                  'images/cameraIcon.png'),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text('Camera')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    selectFile(ImageSource.gallery)
                                        .whenComplete(() {
                                      Get.back();
                                    });
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
                                    child: Column(
                                      children: [
                                        Container(
                                          height:
                                              MediaQuery.of(context).size.width /
                                                  8,
                                          child: Image(
                                            image: AssetImage(
                                                'images/galleryIcon.png'),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text('Gallery')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
              sendImage().whenComplete(() {
                Provider.of<FirebaseOperations>(context, listen: false)
                    .uploadPostData(titleController.text, {
                  'title': titleController.text,
                  'image': file == null
                      ? 'https://firebasestorage.googleapis.com/v0/b/uniguide-a6633.appspot.com/o/const_image.png?alt=media&token=6e7d4e3e-4efc-41a2-b182-58ec059b2a80'
                      : imageUrl,
                  'category': chosenTopic,
                  'fullname':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .getInitFullname,
                  'avatar':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .getInitAvatar,
                  'email':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .geiInitEmail,
                  'useruid': Provider.of<Authentication>(context, listen: false)
                      .getUserUid,
                  'time': Timestamp.now(),
                  'likes': 0,
                  'comments': 0,
                }).whenComplete(() {
                  file = null;
                  titleController.clear();
                  FocusScope.of(context).unfocus();
                  // FocusScope.of(context).requestFocus(FocusNode());
                  print('Post uploaded');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
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
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFB7C1F4).withOpacity(0.3)),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Center(child: Text('Choose a community')),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('Attached File: '),
                              ),
                              Container(
                                height: 250,
                                child: Image(
                                  image: FileImage(file),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Expanded(
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
                            maxLines: 28,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write please your problem',
                            ),
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
