import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/post_functions.dart';

import 'package:uniguide/screens/dashboard/controllers/blog_controller.dart';
import 'package:uniguide/screens/dashboard/controllers/dashboard_controller.dart';
import 'package:uniguide/screens/dashboard/models/dashboard_model.dart';

import 'package:uniguide/services/auth_service.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_card.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_in_comment_card.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'package:intl/intl.dart';

DashboardController dc = Get.put(DashboardController());

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  BlogController controller = BlogController();

  TextEditingController commentC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dc.getCurrentProfile();
  }

  // sorting widgets:
  var newContColor = darPurple;
  var newTextColor = white;

  var intContColor = white;
  var intTextColor = black.withOpacity(0.2);

  var discContColor = white;
  var discTextColor = black.withOpacity(0.2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Blog',
          style: titleStyle,
        ),
        actions: [
          IconButton(
              icon: ImageIcon(
                AssetImage('images/filter.png'),
              ),
              color: Color(0xFF232195),
              iconSize: 20,
              onPressed: () async {
                Provider.of<Authentication>(context, listen: false)
                    .logOutViaEmail();
                Get.offNamed('/login');
                // - - - - DONT DELETE - - - -

                // Get.bottomSheet(Container(
                //   height: 500,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //         topRight: Radius.circular(20.0),
                //         topLeft: Radius.circular(20.0)),
                //     color: Colors.white,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 20.0, vertical: 40),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         WideButtonBox(
                //           ElevatedButton(
                //             child: Text(
                //               'Choose',
                //               style: TextStyle(
                //                   color: Color(0xFF141619),
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             onPressed: () {
                //               Get.back();
                //             },
                //             style: ElevatedButton.styleFrom(
                //               primary: Color(0xFFB7C1F4),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius:
                //                     BorderRadius.circular(10),
                //               ),
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        newContColor = darPurple;
                        newTextColor = white;

                        intContColor = white;
                        intTextColor = black.withOpacity(0.2);

                        discContColor = white;
                        discTextColor = black.withOpacity(0.2);
                      });
                    },
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: newContColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 2),
                        child: Text(
                          '#новые',
                          style: TextStyle(
                            color: newTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        newContColor = white;
                        newTextColor = black.withOpacity(0.2);

                        intContColor = darPurple;
                        intTextColor = white;

                        discContColor = white;
                        discTextColor = black.withOpacity(0.2);
                      });
                    },
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: intContColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 2),
                        child: Text(
                          '#интересные',
                          style: TextStyle(
                            color: intTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        newContColor = white;
                        newTextColor = black.withOpacity(0.2);

                        intContColor = white;
                        intTextColor = black.withOpacity(0.2);

                        discContColor = darPurple;
                        discTextColor = white;
                      });
                    },
                    child: Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: discContColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 2),
                        child: Text(
                          '#обсуждаемые',
                          style: TextStyle(
                            color: discTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 666,
                minHeight: 400,
              ),
              height: 700,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('posts').orderBy('time', descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    );
                  } else {
                    return loadPosts(context, snapshot);
                  }
                },
              ),
            ),
            // Container(
            //   height: 670,
            //   child: GetBuilder<BlogController>(
            //     init: BlogController(),
            //     builder: (value) {
            //       return FutureBuilder(
            //           future: value.getData('blogs'),
            //           builder: (context, snapshot) {
            //             if (snapshot.connectionState ==
            //                 ConnectionState.waiting) {
            //               return Center(
            //                 child: CircularProgressIndicator(
            //                   backgroundColor: Colors.black,
            //                 ),
            //               );
            //             } else {
            //               return ListView.builder(
            //                 itemCount: snapshot.data.length,
            //                 itemBuilder: (BuildContext, int index) {
            //                   return PostCard(
            //                     category:
            //                         snapshot.data[index].data()['category'],
            //                     image: snapshot.data[index].data()['sender']
            //                         ['image'],
            //                     sender: snapshot.data[index].data()['sender']
            //                         ['fullName'],
            //                     sendTime:
            //                         snapshot.data[index].data()['sendTime'],
            //                     title: snapshot.data[index].data()['title'],
            //                     comments:
            //                         snapshot.data[index].data()['comments'],
            //                     likes: snapshot.data[index].data()['likes'],
            //                   );
            //                 },
            //               );
            //             }
            //           });
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
        Provider.of<PostFunctions>(context, listen: false).showTimeAgo(documentSnapshot.data()['time']);
        return PostCard(
            category: documentSnapshot.data()['category'],
            // image: documentSnapshot.data()['avatar'],
            avatar: documentSnapshot.data()['avatar'],
            sender: documentSnapshot.data()['fullname'],
            title: documentSnapshot.data()['title'],
            timeAgo: Provider.of<PostFunctions>(context, listen: false).getTimePosted.toString(),
            likes: Container(
              width: 40,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(documentSnapshot.data()['title'])
                    .collection('likes')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Text(
                      snapshot.data.docs.length.toString(),
                      style: TextStyle(
                          color: Color(0xFF687684),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    );
                  }
                },
              ),
            ),
            comments: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(documentSnapshot.data()['title'])
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Text(
                    snapshot.data.docs.length.toString(),
                    style: TextStyle(
                        color: Color(0xFF687684),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  );
                }
              },
            ),
            onComment: () {
              // Provider.of<PostFunctions>(context, listen: false)
              //     .showComments(context, documentSnapshot, documentSnapshot.data()['title']);
              // Get.to(() => CommentsScreen());

              Get.to(
                () => Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Get.back();
                        commentC.clear();
                      },
                    ),
                    title: Text('comments secwn'),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PostInCommentCard(
                            category: documentSnapshot.data()['category'],
                            avatar: documentSnapshot.data()['avatar'],
                            sender: documentSnapshot.data()['fullname'],
                            title: documentSnapshot.data()['title'],
                            comments: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(documentSnapshot.data()['title'])
                                  .collection('comments')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Text(
                                    snapshot.data.docs.length.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF687684),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  );
                                }
                              },
                            ),
                            onLike: () {
                              print('Liking post...');
                              Provider.of<PostFunctions>(context, listen: false)
                                  .addLike(
                                      context,
                                      documentSnapshot.data()['title'],
                                      Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserUid);
                            },
                            likes: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(documentSnapshot.data()['title'])
                                  .collection('likes')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data.docs.length.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF687684),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  );
                                }
                              },
                            ),
                          ),
                          Text('Начало обсуждения'),
                          Container(
                            height: 300,
                            child: Provider.of<PostFunctions>(context,
                                    listen: false)
                                .showComments(context, documentSnapshot,
                                    documentSnapshot.data()['title']),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: TextField(
                                    controller: commentC,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('adding comment');
                                      Provider.of<PostFunctions>(context,
                                              listen: false)
                                          .addComment(
                                              context,
                                              documentSnapshot.data()['title'],
                                              commentC.text)
                                          .whenComplete(() {
                                        commentC.clear();
                                      });
                                    },
                                    child: Text('->'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );

              // dc.getCurrentProfile();
              // PostFunctions().addComment(context, documentSnapshot.data()['title'], 'kuka');
              // PostFunctions().showCommentsPage(context, documentSnapshot, documentSnapshot.data()['title']);
              // Get.to(() => CommentsScreen());
            },
            onLikes: () {
              Get.to(
                () => Scaffold(
                  appBar: AppBar(
                    title: Text('likes secwn'),
                  ),
                  body: Container(
                    height: 400,
                    child: Provider.of<PostFunctions>(context, listen: false)
                        .showLikes(
                      context,
                      documentSnapshot.data()['title'],
                    ),
                  ),
                ),
              );
            },
            onLikeButton: () {
              print('Liking post...');
              Provider.of<PostFunctions>(context, listen: false).addLike(
                  context,
                  documentSnapshot.data()['title'],
                  Provider.of<Authentication>(context, listen: false)
                      .getUserUid);
            });
      }).toList(),
    );
  }
}
