import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/screens/dashboard/controllers/blog_controller.dart';
import 'package:uniguide/screens/dashboard/models/dashboard_model.dart';
import 'package:uniguide/services/auth_service.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_card.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'package:intl/intl.dart';

class BlogScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  BlogController controller = BlogController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Blogs', style: titleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                        icon: ImageIcon(
                          AssetImage('images/filter.png'),
                        ),
                        color: Color(0xFF232195),
                        iconSize: 20,
                        onPressed: () async {
                          Get.bottomSheet(Container(
                            height: 500,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  WideButtonBox(
                                    ElevatedButton(
                                      child: Text(
                                        'Choose',
                                        style: TextStyle(
                                            color: Color(0xFF141619),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFB7C1F4),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ));
                        }),
                  )
                ],
              ),
            ),
            Container(
              height: 670,
              child: GetBuilder<BlogController>(
                init: BlogController(),
                builder: (value) {
                  return FutureBuilder(
                      future: value.getData('posts'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext, int index) {
                              return PostCard(
                                category:
                                    snapshot.data[index].data()['category'],
                                image: snapshot.data[index].data()['sender']
                                    ['image'],
                                sender: snapshot.data[index].data()['sender']
                                    ['fullName'],
                                sendTime:
                                    snapshot.data[index].data()['sendTime'],
                                title: snapshot.data[index].data()['title'],
                                comments:
                                    snapshot.data[index].data()['comments'],
                                likes: snapshot.data[index].data()['likes'],
                              );
                            },
                          );
                        }
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
