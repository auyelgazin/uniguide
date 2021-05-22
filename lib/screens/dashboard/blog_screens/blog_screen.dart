import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/colors.dart';
import 'package:uniguide/constants/consants.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/authentication.dart';
import 'package:uniguide/provider_files/firebase_operations.dart';
import 'package:uniguide/provider_files/post_functions.dart';
import 'package:uniguide/screens/dashboard/models/topic.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_card.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_in_comment_card.dart';
import 'package:uniguide/widgets/wide_button_box.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  TextEditingController _commentC = TextEditingController();
  List<String> topics = Topic.topics;

  String _orderBy = 'time';
  // sorting widgets:
  var _newContColor = darPurple;
  var _newTextColor = white;

  var _intContColor = white;
  var _intTextColor = black.withOpacity(0.2);

  var _discContColor = white;
  var _discTextColor = black.withOpacity(0.2);

  // @override
  // void initState() {
  //   Provider.of<Authentication>(context, listen: false)
  //       .getUID();
  //   Provider.of<FirebaseOperations>(context, listen: false)
  //       .initUserData(context);
  //   super.initState();
  // }

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

              

              // - - - - DONT DELETE - - - -
              // Get.bottomSheet(
              //   Container(
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
              //       child: ListView.builder(
              //           itemCount: topics.length,
              //           itemBuilder: (BuildContext ctxt, int index) {
              //             return new Text(topics[index]);
              //           }),
              //     ),
              //   ),
              // );
            },
          ),
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
                      _orderBy = 'time';
                      _newContColor = darPurple;
                      _newTextColor = white;

                      _intContColor = white;
                      _intTextColor = black.withOpacity(0.2);

                      _discContColor = white;
                      _discTextColor = black.withOpacity(0.2);
                    });
                  },
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: _newContColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 2),
                      child: Text(
                        '#new',
                        style: TextStyle(
                          color: _newTextColor,
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
                      _orderBy = 'likes';
                      _newContColor = white;
                      _newTextColor = black.withOpacity(0.2);

                      _intContColor = darPurple;
                      _intTextColor = white;

                      _discContColor = white;
                      _discTextColor = black.withOpacity(0.2);
                    });
                  },
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: _intContColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 2),
                      child: Text(
                        '#best',
                        style: TextStyle(
                          color: _intTextColor,
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
                    _orderBy = 'comments';
                    setState(() {
                      _newContColor = white;
                      _newTextColor = black.withOpacity(0.2);

                      _intContColor = white;
                      _intTextColor = black.withOpacity(0.2);

                      _discContColor = darPurple;
                      _discTextColor = white;
                    });
                  },
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: _discContColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 2),
                      child: Text(
                        '#most discussed',
                        style: TextStyle(
                          color: _discTextColor,
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
                  
                  .orderBy(_orderBy, descending: true)
                  // .where('category', isEqualTo: 'Lost-found')
                  .snapshots(),
              builder: (context, snapshot) {
                
                if (!snapshot.hasData) {
                  return Text('There is no any posts yet.');
                  // return CircularProgressIndicator();
                }
                else if (snapshot.hasData){
                  // print('=== data ===: ${snapshot.data}');
                  return loadPosts(context, snapshot);
                }
                else{
                  print('$arrow Loading...');
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // filterByCategory() async{
  //   List<dynamic> posts = [];

  //   StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance.collection('posts').snapshots(),
  //     builder: (context, snapshot){
  //       return loadPosts(context, snapshot);
  //     },
  //   );
  // }

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
                                _commentC.clear();
                              },
                            ),
                          ),
                          title: Text(
                            'Comments',
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
                                    'Discussion start',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 480,
                                    child: Provider.of<PostFunctions>(context,
                                            listen: false)
                                        .showComments(context, documentSnapshot,
                                            documentSnapshot.data()['title']),
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                            controller: _commentC,
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
                                              hintText: 'Add a comment...',
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
                                                  _commentC.text)
                                              .whenComplete(() {
                                            _commentC.clear();
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
                          _commentC.clear();
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
