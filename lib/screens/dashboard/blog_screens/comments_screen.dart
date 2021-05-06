import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uniguide/constants/font_styles.dart';
import 'package:uniguide/provider_files/post_functions.dart';
import 'package:uniguide/screens/dashboard/blog_screens/utils/post_options.dart';

import 'package:uniguide/widgets/dashboard_widgets/comment_card.dart';
import 'package:uniguide/widgets/dashboard_widgets/post_card.dart';

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF232195),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          'Comments',
          style: titleStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Начало обсуждения'),
            // Provider.of<PostFunctions>(context, listen: false).showComments(context, snapshot, docId),

            Row(
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
                      // Provider.of<PostFunctions>(context, listen: false).addComment(context, postId, comment)
                    },
                    child: Text('->'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      // body: showCommentsPage(context, snapshot, docID),
      // body: PostFunctions().showCommentsPage(context, snapshot, docID),
    );
  }

  // showCommentsPage(
  //     BuildContext context, DocumentSnapshot snapshot, String docID) {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Text('Comments Section: '),
  //         Container(
  //           height: 200,
  //           child: StreamBuilder<QuerySnapshot>(
  //             stream: FirebaseFirestore.instance
  //                 .collection('posts')
  //                 .doc(docID)
  //                 .collection('comments')
  //                 .orderBy('time')
  //                 .snapshots(),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.waiting) {
  //                 return Center(
  //                   child: CircularProgressIndicator(
  //                     backgroundColor: Colors.black,
  //                   ),
  //                 );
  //               } else {
  //                 return new ListView(
  //                     children: snapshot.data.docs
  //                         .map((DocumentSnapshot documentSnapshot) {
  //                   return CommentCard(
  //                     sender: documentSnapshot.data()['fullName'],
  //                     // image: documentSnapshot.data()['avatar'],
  //                     comment: documentSnapshot.data()['comment'],
  //                   );
  //                 }).toList());
  //               }
  //             },
  //           ),
  //         ),
  //         // Container(
  //         //   width: MediaQuery.of(context).size.width,
  //         //   child: Row(
  //         //     children: [
  //         //       TextField(
  //         //         controller: commentController,
  //         //       ),
  //         //       // ElevatedButton(
  //         //       //   onPressed: () {},
  //         //       //   child: Icon(Icons.send),
  //         //       // )
  //         //     ],
  //         //   ),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  // Widget loadComments(
  //     BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //   return ListView(
  //     children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
  //       return PostCard(
  //         category: documentSnapshot.data()['category'],
  //         // image: documentSnapshot.data()['avatar'],
  //         sender: documentSnapshot.data()['fullName'],
  //         title: documentSnapshot.data()['title'],
  //         onComment: () {
  //           PostOptions()
  //               .addComment(context, documentSnapshot.data()['title'], 'opawa');
  //           PostOptions().showCommentsPage(
  //               context, documentSnapshot, documentSnapshot.data()['title']);
  //           // Get.to(() => CommentsScreen());
  //         },
  //       );
  //     }).toList(),
  //   );
  // }
}
