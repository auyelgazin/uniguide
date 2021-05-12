import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/post_functions.dart';
import 'package:uniguide/services/auth_service.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_card.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_in_comment_card.dart';
import 'package:uniguide/widgets/wide_button_box.dart';
import 'package:intl/intl.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  TextEditingController commentC = TextEditingController();

  String orderBy = 'time';
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
        leadingWidth: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            'Blog',
            style: titleStyle,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              icon: ImageIcon(
                AssetImage('images/filter.png'),
              ),
              color: Color(0xFF232195),
              iconSize: 20,
              onPressed: () async {
                // Provider.of<SurveyFunctions>(context, listen: false)
                //     .showSurveys();
                // Get.offNamed('/login');
                // - - - - DONT DELETE - - - -

                //   Get.bottomSheet(Container(
                //     height: 500,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topRight: Radius.circular(20.0),
                //           topLeft: Radius.circular(20.0)),
                //       color: Colors.white,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 20.0, vertical: 40),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           WideButtonBox(
                //             ElevatedButton(
                //               child: Text(
                //                 'Choose',
                //                 style: TextStyle(
                //                     color: Color(0xFF141619),
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.w500),
                //               ),
                //               onPressed: () {
                //                 Get.back();
                //               },
                //               style: ElevatedButton.styleFrom(
                //                 primary: Color(0xFFB7C1F4),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius:
                //                       BorderRadius.circular(10),
                //                 ),
                //               ),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ));
              }),
        ],
      ),
      body: Column(
        // shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                      orderBy = 'time';
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
                      orderBy = 'likes';
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
                        '#лучшие',
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
                        '#интересные',
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy(orderBy, descending: true)
                  .snapshots(),
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
        ],
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
        Provider.of<PostFunctions>(context, listen: false)
            .showTimeAgo(documentSnapshot.data()['time']);
        return PostCard(
            category: documentSnapshot.data()['category'],
            image: documentSnapshot.data()['image'],
            avatar: documentSnapshot.data()['avatar'],
            sender: documentSnapshot.data()['fullname'],
            title: documentSnapshot.data()['title'],
            timeAgo: Provider.of<PostFunctions>(context, listen: false)
                .getTimePosted
                .toString(),
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
                    return Text(
                      '-',
                      style: TextStyle(
                          color: Color(0xFF687684),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
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
            comments: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(documentSnapshot.data()['title'])
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      width: 10,
                      height: 10,
                    ),
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
            onComment: () {
              // Provider.of<PostFunctions>(context, listen: false)
              //     .showComments(context, documentSnapshot, documentSnapshot.data()['title']);
              // Get.to(() => CommentsScreen());

              Get.to(
                  () => Scaffold(
                        backgroundColor: white,
                        appBar: AppBar(
                          backgroundColor: white,
                          elevation: 0,
                          centerTitle: true,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xFF232195).withOpacity(0.5),
                              ),
                              onPressed: () {
                                Get.back();
                                commentC.clear();
                              },
                            ),
                          ),
                          title: Text(
                            'Коментарии',
                            style: commentsStyle,
                          ),
                        ),
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  PostInCommentCard(
                                    category:
                                        documentSnapshot.data()['category'],
                                    avatar: documentSnapshot.data()['avatar'],
                                    sender: documentSnapshot.data()['fullname'],
                                    title: documentSnapshot.data()['title'],
                                    // timeAgo: Provider.of<PostFunctions>(context,
                                    //         listen: false)
                                    //     .getTimePosted
                                    //     .toString(),
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
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return Text(
                                            snapshot.data.docs.length
                                                .toString(),
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

                                      Provider.of<PostFunctions>(context,
                                              listen: false)
                                          .addLike(
                                              context,
                                              documentSnapshot.data()['title'],
                                              Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getUserUid)
                                          .whenComplete(() {
                                        print('liked');
                                      });
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
                                            snapshot.data.docs.length
                                                .toString(),
                                            style: TextStyle(
                                                color: Color(0xFF687684),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Text(
                                    'Начало обсуждения',
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    height: 520,
                                    child: Provider.of<PostFunctions>(context,
                                            listen: false)
                                        .showComments(context, documentSnapshot,
                                            documentSnapshot.data()['title']),
                                  ),
                                ],
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
                                            controller: commentC,
                                            textAlignVertical:
                                                TextAlignVertical.bottom,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: white,
                                              filled: true,
                                              hintText:
                                                  'Добавить комментарий...',
                                              hintStyle: commentHint,
                                            ),
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
                                          print('adding comment');
                                          Provider.of<PostFunctions>(context,
                                                  listen: false)
                                              .addComment(
                                                  context,
                                                  documentSnapshot
                                                      .data()['title'],
                                                  commentC.text)
                                              .whenComplete(() {
                                            commentC.clear();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  transition: Transition.cupertino);

              // dc.getCurrentProfile();
              // PostFunctions().addComment(context, documentSnapshot.data()['title'], 'kuka');
              // PostFunctions().showCommentsPage(context, documentSnapshot, documentSnapshot.data()['title']);
              // Get.to(() => CommentsScreen());
            },
            onLikes: () {
              print('going to Likes page...');
              Get.to(
                () => Scaffold(
                  backgroundColor: white,
                  appBar: AppBar(
                    backgroundColor: white,
                    elevation: 0,
                    centerTitle: true,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF232195).withOpacity(0.5),
                        ),
                        onPressed: () {
                          Get.back();
                          commentC.clear();
                        },
                      ),
                    ),
                    title: Text(
                      'Likes',
                      style: commentsStyle,
                    ),
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
              // Provider.of<PostFunctions>(context, listen: false).incrementLike(context, documentSnapshot.data()['title']);
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
